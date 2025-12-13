import React, { useState } from 'react';
import { Link as RouterLink } from 'react-router-dom';
import {
  Box,
  Paper,
  Typography,
  TextField,
  Button,
  Link,
  Alert,
  CircularProgress,
  useTheme,
} from '@mui/material';
import { ArrowBack, Email } from '@mui/icons-material';
import * as yup from 'yup';
import { apiClient } from '../services/api';

const forgotPasswordSchema = yup.object().shape({
  email: yup
    .string()
    .email('Please enter a valid email address')
    .required('Email is required'),
});

const ForgotPassword: React.FC = () => {
  const theme = useTheme();
  const [email, setEmail] = useState('');
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [validationError, setValidationError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setValidationError('');

    try {
      await forgotPasswordSchema.validate({ email });
    } catch (err) {
      if (err instanceof yup.ValidationError) {
        setValidationError(err.message);
        return;
      }
    }

    setIsLoading(true);

    try {
      const response = await apiClient.post({
        service: 'auth',
        action: 'forgot_password',
        payload: { email },
      });

      if (response.success) {
        setSuccess(true);
      } else {
        setSuccess(true);
      }
    } catch {
      setSuccess(true);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Box
      sx={{
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: theme.palette.mode === 'dark'
          ? 'linear-gradient(135deg, #0f172a 0%, #1e293b 100%)'
          : 'linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%)',
        p: 2,
      }}
    >
      <Paper
        elevation={0}
        sx={{
          p: 4,
          maxWidth: 420,
          width: '100%',
          borderRadius: 4,
          boxShadow: '0 20px 60px rgba(0,0,0,0.15)',
        }}
      >
        <Box sx={{ textAlign: 'center', mb: 4 }}>
          <Box
            sx={{
              width: 60,
              height: 60,
              borderRadius: 3,
              background: 'linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              mx: 'auto',
              mb: 2,
            }}
          >
            <Email sx={{ color: 'white', fontSize: 28 }} />
          </Box>
          <Typography variant="h4" fontWeight={700} gutterBottom>
            Forgot Password?
          </Typography>
          <Typography variant="body2" color="text.secondary">
            Enter your email and we'll send you reset instructions
          </Typography>
        </Box>

        {error && (
          <Alert severity="error" sx={{ mb: 3, borderRadius: 2 }}>
            {error}
          </Alert>
        )}

        {success ? (
          <Box sx={{ textAlign: 'center' }}>
            <Alert severity="success" sx={{ mb: 3, borderRadius: 2 }}>
              If an account exists with this email, you will receive password reset instructions shortly.
            </Alert>
            <Button
              component={RouterLink}
              to="/login"
              startIcon={<ArrowBack />}
              variant="outlined"
              fullWidth
              sx={{ mt: 2 }}
            >
              Back to Login
            </Button>
          </Box>
        ) : (
          <Box component="form" onSubmit={handleSubmit}>
            <TextField
              fullWidth
              label="Email Address"
              type="email"
              value={email}
              onChange={(e) => {
                setEmail(e.target.value);
                setValidationError('');
              }}
              error={!!validationError}
              helperText={validationError}
              sx={{ mb: 3 }}
            />

            <Button
              fullWidth
              type="submit"
              variant="contained"
              size="large"
              disabled={isLoading}
              sx={{ mb: 2, py: 1.5 }}
            >
              {isLoading ? <CircularProgress size={24} color="inherit" /> : 'Send Reset Link'}
            </Button>

            <Box sx={{ textAlign: 'center' }}>
              <Link
                component={RouterLink}
                to="/login"
                underline="hover"
                sx={{ display: 'inline-flex', alignItems: 'center', gap: 0.5 }}
              >
                <ArrowBack fontSize="small" />
                Back to Login
              </Link>
            </Box>
          </Box>
        )}
      </Paper>
    </Box>
  );
};

export default ForgotPassword;
