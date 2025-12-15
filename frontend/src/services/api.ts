import axios, { type AxiosInstance } from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL as string;

if (!API_BASE_URL) {
  throw new Error('VITE_API_BASE_URL is not set');
}

interface GatewayRequest {
  service: string;
  action: string;
  payload: Record<string, unknown>;
}

interface GatewayResponse {
  success: boolean;
  data?: unknown;
  error?: string;
  error_code?: string;
}

class ApiClient {
  private client: AxiosInstance;
  private debounceTimers: Map<string, ReturnType<typeof setTimeout>> = new Map();
  private throttleTimestamps: Map<string, number> = new Map();

  constructor() {
    this.client = axios.create({
      baseURL: API_BASE_URL,
      headers: {
        'Content-Type': 'application/json',
      },
    });

    this.client.interceptors.request.use((config) => {
      const token = localStorage.getItem('access_token');
      if (token) {
        config.headers.Authorization = `Bearer ${token}`;
      }
      return config;
    });

    this.client.interceptors.response.use(
      (response) => response,
      async (error) => {
        if (error.response?.status === 401) {
          const refreshToken = localStorage.getItem('refresh_token');
          if (refreshToken) {
            try {
              const response = await this.post({
                service: 'auth',
                action: 'refresh',
                payload: { refresh_token: refreshToken },
              });
              if (response.success && response.data) {
                localStorage.setItem('access_token', (response.data as { access_token: string }).access_token);
                localStorage.setItem('refresh_token', (response.data as { refresh_token: string }).refresh_token);
                error.config.headers.Authorization = `Bearer ${(response.data as { access_token: string }).access_token}`;
                return this.client.request(error.config);
              }
            } catch {
              localStorage.removeItem('access_token');
              localStorage.removeItem('refresh_token');
              window.location.href = '/login';
            }
          }
        }
        return Promise.reject(error);
      }
    );
  }

  async post(request: GatewayRequest): Promise<GatewayResponse> {
    try {
      const response = await this.client.post('/gateway', request);
      return response.data;
    } catch (error: unknown) {
      if (axios.isAxiosError(error) && error.response?.data) {
        return error.response.data;
      }
      return {
        success: false,
        error: 'Network error',
        error_code: 'NETWORK_ERROR',
      };
    }
  }

  debounce<T>(key: string, fn: () => Promise<T>, delay: number = 300): Promise<T> {
    return new Promise((resolve) => {
      const existing = this.debounceTimers.get(key);
      if (existing) {
        clearTimeout(existing);
      }

      const timer = setTimeout(async () => {
        this.debounceTimers.delete(key);
        const result = await fn();
        resolve(result);
      }, delay);

      this.debounceTimers.set(key, timer);
    });
  }

  throttle<T>(key: string, fn: () => Promise<T>, interval: number = 1000): Promise<T> | null {
    const now = Date.now();
    const lastCall = this.throttleTimestamps.get(key) || 0;

    if (now - lastCall < interval) {
      return null;
    }

    this.throttleTimestamps.set(key, now);
    return fn();
  }
}

export const apiClient = new ApiClient();
