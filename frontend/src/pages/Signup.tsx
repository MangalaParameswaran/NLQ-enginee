import React, { useState } from "react";
import { useNavigate, Link as RouterLink } from "react-router-dom";
import {
  Box,
  Paper,
  Typography,
  TextField,
  Button,
  Link,
  Alert,
  CircularProgress,
  Grid,
  useTheme,
} from "@mui/material";
import * as yup from "yup";
import { useAuth } from "../context/AuthContext";

const signupSchema = yup.object().shape({
  name: yup
    .string()
    .min(2, "Name must be at least 2 characters")
    .required("Full name is required"),
  email: yup
    .string()
    .email("Please enter a valid email address")
    .required("Email is required"),
  password: yup
    .string()
    .min(8, "Password must be at least 8 characters")
    .matches(/[A-Z]/, "Password must contain at least one uppercase letter")
    .matches(/[0-9]/, "Password must contain at least one number")
    .required("Password is required"),
  confirmPassword: yup
    .string()
    .oneOf([yup.ref("password")], "Passwords must match")
    .required("Please confirm your password"),
  org: yup
    .string()
    .min(2, "Organization must be at least 2 characters")
    .required("Organization is required"),
  tenant_name: yup
    .string()
    .min(2, "Tenant name must be at least 2 characters")
    .required("Tenant name is required"),
  phone_number: yup.string().optional(),
});

const Signup: React.FC = () => {
  const theme = useTheme();
  const navigate = useNavigate();
  const { signup } = useAuth();
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    password: "",
    confirmPassword: "",
    org: "",
    tenant_name: "",
    phone_number: "",
  });
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [submitError, setSubmitError] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
    if (errors[name]) {
      setErrors((prev) => ({ ...prev, [name]: "" }));
    }
  };

  const validateField = async (field: string) => {
    try {
      await signupSchema.validateAt(field, formData);
      setErrors((prev) => ({ ...prev, [field]: "" }));
    } catch (err) {
      if (err instanceof yup.ValidationError) {
        setErrors((prev) => ({ ...prev, [field]: err.message }));
      }
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitError("");
    setErrors({});

    try {
      await signupSchema.validate(formData, { abortEarly: false });
    } catch (err) {
      if (err instanceof yup.ValidationError) {
        const newErrors: Record<string, string> = {};
        err.inner.forEach((error) => {
          if (error.path) {
            newErrors[error.path] = error.message;
          }
        });
        setErrors(newErrors);
        return;
      }
    }

    setIsLoading(true);

    try {
      await signup({
        name: formData.name,
        email: formData.email,
        password: formData.password,
        org: formData.org,
        tenant_name: formData.tenant_name,
        phone_number: formData.phone_number || undefined,
      });
      navigate("/");
    } catch (err: unknown) {
      const errorMessage = err instanceof Error ? err.message : "Signup failed";
      setSubmitError(errorMessage);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Box
      sx={{
        minHeight: "100vh",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        background:
          theme.palette.mode === "dark"
            ? "linear-gradient(135deg, #0f172a 0%, #1e293b 100%)"
            : "linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%)",
        p: 2,
      }}
    >
      <Paper
        elevation={0}
        sx={{
          p: 4,
          maxWidth: 520,
          width: "100%",
          borderRadius: 4,
          boxShadow: "0 20px 60px rgba(0,0,0,0.15)",
          mx: "auto",
        }}
      >
        <Box sx={{ textAlign: "center", mb: 4 }}>
          <Box
            sx={{
              width: 60,
              height: 60,
              borderRadius: 3,
              background: "linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              mx: "auto",
              mb: 2,
            }}
          >
            <Typography variant="h4" sx={{ color: "white", fontWeight: 700 }}>
              N
            </Typography>
          </Box>
          <Typography variant="h4" fontWeight={700} gutterBottom>
            Create Account
          </Typography>
          <Typography variant="body2" color="text.secondary">
            Get started with NLQ Engine
          </Typography>
        </Box>

        {submitError && (
          <Alert severity="error" sx={{ mb: 3, borderRadius: 2 }}>
            {submitError}
          </Alert>
        )}

        <Box component="form" onSubmit={handleSubmit}>
          <Grid container spacing={2}>
            <Grid size={12}>
              <TextField
                fullWidth
                label="Full Name"
                name="name"
                value={formData.name}
                onChange={handleChange}
                onBlur={() => validateField("name")}
                error={!!errors.name}
                helperText={errors.name}
              />
            </Grid>
            <Grid size={12}>
              <TextField
                fullWidth
                label="Email"
                name="email"
                type="email"
                value={formData.email}
                onChange={handleChange}
                onBlur={() => validateField("email")}
                error={!!errors.email}
                helperText={errors.email}
              />
            </Grid>
            <Grid size={{ xs: 12, sm: 6 }}>
              <TextField
                fullWidth
                label="Password"
                name="password"
                type="password"
                value={formData.password}
                onChange={handleChange}
                onBlur={() => validateField("password")}
                error={!!errors.password}
                helperText={errors.password}
              />
            </Grid>
            <Grid size={{ xs: 12, sm: 6 }}>
              <TextField
                fullWidth
                label="Confirm Password"
                name="confirmPassword"
                type="password"
                value={formData.confirmPassword}
                onChange={handleChange}
                onBlur={() => validateField("confirmPassword")}
                error={!!errors.confirmPassword}
                helperText={errors.confirmPassword}
              />
            </Grid>
            <Grid size={{ xs: 12, sm: 6 }}>
              <TextField
                fullWidth
                label="Org Code"
                name="org"
                value={formData.org}
                onChange={handleChange}
                onBlur={() => validateField("org")}
                error={!!errors.org}
                helperText={errors.org || "e.g., ITL, ITD"}
                placeholder="e.g., ITL, ITD"
              />
            </Grid>
            <Grid size={{ xs: 12, sm: 6 }}>
              <TextField
                fullWidth
                label="Org Name"
                name="tenant_name"
                value={formData.tenant_name}
                onChange={handleChange}
                onBlur={() => validateField("tenant_name")}
                error={!!errors.tenant_name}
                helperText={errors.tenant_name || "Your company name"}
                placeholder="Your company name"
              />
            </Grid>
            <Grid size={12}>
              <TextField
                fullWidth
                label="Phone Number (optional)"
                name="phone_number"
                value={formData.phone_number}
                onChange={handleChange}
              />
            </Grid>
          </Grid>

          <Button
            fullWidth
            type="submit"
            variant="contained"
            size="large"
            disabled={isLoading}
            sx={{ mt: 3, mb: 2, py: 1.5 }}
          >
            {isLoading ? (
              <CircularProgress size={24} color="inherit" />
            ) : (
              "Create Account"
            )}
          </Button>

          <Typography variant="body2" textAlign="center" color="text.secondary">
            Already have an account?{" "}
            <Link component={RouterLink} to="/login" underline="hover">
              Sign in
            </Link>
          </Typography>
        </Box>
      </Paper>
    </Box>
  );
};

export default Signup;
