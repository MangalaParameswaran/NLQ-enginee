import React, { createContext, useState, useContext, useEffect } from 'react';
import { apiClient } from '../services/api';

interface User {
  id: number;
  email: string;
  name: string;
  phone_number?: string;
  profile_picture?: string;
  tenant_id: number;
  tenant_name: string;
  organization_id: number;
  org_name: string;
  is_active: boolean;
  created_at: string;
}

interface AuthContextType {
  user: User | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  login: (email: string, password: string, org: string) => Promise<void>;
  signup: (data: SignupData) => Promise<void>;
  logout: () => void;
  refreshAuth: () => Promise<void>;
}

interface SignupData {
  name: string;
  email: string;
  password: string;
  org: string;
  tenant_name: string;
  phone_number?: string;
  profile_picture?: string;
}

const AuthContext = createContext<AuthContextType>({
  user: null,
  isAuthenticated: false,
  isLoading: true,
  login: async () => {},
  signup: async () => {},
  logout: () => {},
  refreshAuth: async () => {},
});

export const useAuth = () => useContext(AuthContext);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const initAuth = async () => {
      const token = localStorage.getItem('access_token');
      if (token) {
        try {
          await refreshAuth();
        } catch {
          localStorage.removeItem('access_token');
          localStorage.removeItem('refresh_token');
        }
      }
      setIsLoading(false);
    };
    initAuth();
  }, []);

  const login = async (email: string, password: string, org: string) => {
    const response = await apiClient.post({
      service: 'auth',
      action: 'login',
      payload: { email, password, org },
    });

    if (response.success && response.data) {
      const { user: userData, tokens } = response.data;
      localStorage.setItem('access_token', tokens.access_token);
      localStorage.setItem('refresh_token', tokens.refresh_token);
      setUser(userData);
    } else {
      throw new Error(response.error || 'Login failed');
    }
  };

  const signup = async (data: SignupData) => {
    const response = await apiClient.post({
      service: 'auth',
      action: 'signup',
      payload: data,
    });

    if (response.success && response.data) {
      const { user: userData, tokens } = response.data;
      localStorage.setItem('access_token', tokens.access_token);
      localStorage.setItem('refresh_token', tokens.refresh_token);
      setUser(userData);
    } else {
      throw new Error(response.error || 'Signup failed');
    }
  };

  const logout = () => {
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
    setUser(null);
  };

  const refreshAuth = async () => {
    const response = await apiClient.post({
      service: 'auth',
      action: 'get_user',
      payload: {},
    });

    if (response.success && response.data) {
      setUser(response.data);
    } else {
      throw new Error('Session expired');
    }
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        isAuthenticated: !!user,
        isLoading,
        login,
        signup,
        logout,
        refreshAuth,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};
