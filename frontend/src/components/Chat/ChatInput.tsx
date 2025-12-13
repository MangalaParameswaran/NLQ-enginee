import React, { useState, useEffect, useRef, useCallback } from 'react';
import {
  Box,
  TextField,
  IconButton,
  Paper,
  Tooltip,
  CircularProgress,
  useTheme,
  ToggleButtonGroup,
  ToggleButton,
  Typography,
  InputAdornment,
} from '@mui/material';
import { Send, Mic, Stop, Insights, TableChart, BarChart, Download, Clear } from '@mui/icons-material';

export type OutputPreference = 'insights' | 'table' | 'chart' | 'download';

interface ChatInputProps {
  onSend: (message: string, outputPreference: OutputPreference) => void;
  isLoading: boolean;
  disabled?: boolean;
}

interface SpeechRecognitionEvent {
  resultIndex: number;
  results: SpeechRecognitionResultList;
}

interface SpeechRecognitionResultList {
  length: number;
  [index: number]: SpeechRecognitionResult;
}

interface SpeechRecognitionResult {
  isFinal: boolean;
  [index: number]: SpeechRecognitionAlternative;
}

interface SpeechRecognitionAlternative {
  transcript: string;
  confidence: number;
}

interface SpeechRecognition extends EventTarget {
  continuous: boolean;
  interimResults: boolean;
  lang: string;
  onresult: ((event: SpeechRecognitionEvent) => void) | null;
  onerror: ((event: Event) => void) | null;
  onend: (() => void) | null;
  start: () => void;
  stop: () => void;
  abort: () => void;
}

declare global {
  interface Window {
    SpeechRecognition: new () => SpeechRecognition;
    webkitSpeechRecognition: new () => SpeechRecognition;
  }
}

const ChatInput: React.FC<ChatInputProps> = ({ onSend, isLoading, disabled }) => {
  const theme = useTheme();
  const [message, setMessage] = useState('');
  const [outputPreference, setOutputPreference] = useState<OutputPreference>('chart');
  const [isListening, setIsListening] = useState(false);
  const recognitionRef = useRef<SpeechRecognition | null>(null);
  const isListeningRef = useRef(false);

  const isSupported = typeof window !== 'undefined' && 
    ('SpeechRecognition' in window || 'webkitSpeechRecognition' in window);

  const stopListening = useCallback(() => {
    if (recognitionRef.current && isListeningRef.current) {
      recognitionRef.current.stop();
      isListeningRef.current = false;
      setIsListening(false);
    }
  }, []);

  const startListening = useCallback(() => {
    if (!isSupported) return;
    
    if (isListeningRef.current) {
      stopListening();
      return;
    }

    if (recognitionRef.current) {
      recognitionRef.current.abort();
    }

    const SpeechRecognitionAPI = window.SpeechRecognition || window.webkitSpeechRecognition;
    const recognition = new SpeechRecognitionAPI();

    recognition.continuous = false;
    recognition.interimResults = true;
    recognition.lang = 'en-US';

    recognition.onresult = (event: SpeechRecognitionEvent) => {
      let transcript = '';
      for (let i = event.resultIndex; i < event.results.length; i++) {
        transcript += event.results[i][0].transcript;
      }
      setMessage(transcript);
    };

    recognition.onerror = () => {
      isListeningRef.current = false;
      setIsListening(false);
    };

    recognition.onend = () => {
      isListeningRef.current = false;
      setIsListening(false);
    };

    recognitionRef.current = recognition;
    recognition.start();
    isListeningRef.current = true;
    setIsListening(true);
  }, [isSupported, stopListening]);

  useEffect(() => {
    return () => {
      if (recognitionRef.current) {
        recognitionRef.current.abort();
      }
    };
  }, []);

  const handleSubmit = (e?: React.FormEvent) => {
    e?.preventDefault();
    const trimmedMessage = message.trim();
    if (trimmedMessage && !isLoading && !disabled) {
      stopListening();
      onSend(trimmedMessage, outputPreference);
      setMessage('');
    }
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSubmit();
    }
  };

  const handleClear = () => {
    setMessage('');
    stopListening();
  };

  const handleOutputChange = (_: React.MouseEvent<HTMLElement>, newValue: OutputPreference | null) => {
    if (newValue) {
      setOutputPreference(newValue);
    }
  };

  return (
    <Paper
      elevation={0}
      sx={{
        p: 2,
        borderTop: `1px solid ${theme.palette.divider}`,
        background: theme.palette.background.paper,
      }}
    >
      <Box sx={{ maxWidth: 900, mx: 'auto' }}>
        <Box sx={{ mb: 1.5, display: 'flex', alignItems: 'center', gap: 1.5 }}>
          <Typography variant="caption" color="text.secondary" sx={{ minWidth: 'fit-content' }}>
            Show as:
          </Typography>
          <ToggleButtonGroup
            value={outputPreference}
            exclusive
            onChange={handleOutputChange}
            size="small"
            sx={{
              '& .MuiToggleButton-root': {
                borderRadius: 2,
                px: 1.5,
                py: 0.5,
                textTransform: 'none',
                fontSize: 12,
                '&.Mui-selected': {
                  background: 'linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%)',
                  color: 'white',
                  '&:hover': {
                    background: 'linear-gradient(135deg, #2563eb 0%, #7c3aed 100%)',
                  },
                },
              },
            }}
          >
            <ToggleButton value="insights">
              <Insights sx={{ fontSize: 16, mr: 0.5 }} />
              Insights
            </ToggleButton>
            <ToggleButton value="table">
              <TableChart sx={{ fontSize: 16, mr: 0.5 }} />
              Table
            </ToggleButton>
            <ToggleButton value="chart">
              <BarChart sx={{ fontSize: 16, mr: 0.5 }} />
              Chart
            </ToggleButton>
            <ToggleButton value="download">
              <Download sx={{ fontSize: 16, mr: 0.5 }} />
              Download
            </ToggleButton>
          </ToggleButtonGroup>
        </Box>

        <Box
          component="form"
          onSubmit={handleSubmit}
          sx={{
            display: 'flex',
            alignItems: 'flex-end',
            gap: 1,
          }}
        >
          <TextField
            fullWidth
            multiline
            maxRows={4}
            placeholder="Ask a question about your data..."
            value={message}
            onChange={(e) => setMessage(e.target.value)}
            onKeyPress={handleKeyPress}
            disabled={disabled || isLoading}
            slotProps={{
              input: {
                endAdornment: message && (
                  <InputAdornment position="end">
                    <IconButton
                      size="small"
                      onClick={handleClear}
                      sx={{ 
                        opacity: 0.6, 
                        '&:hover': { opacity: 1 },
                        mr: -0.5,
                      }}
                    >
                      <Clear fontSize="small" />
                    </IconButton>
                  </InputAdornment>
                ),
              },
            }}
            sx={{
              '& .MuiOutlinedInput-root': {
                borderRadius: 3,
                background: theme.palette.mode === 'dark' ? 'rgba(255,255,255,0.05)' : 'rgba(0,0,0,0.02)',
                '&:hover': {
                  background: theme.palette.mode === 'dark' ? 'rgba(255,255,255,0.08)' : 'rgba(0,0,0,0.04)',
                },
              },
            }}
          />

          {isSupported && (
            <Tooltip title={isListening ? 'Stop recording' : 'Voice input'}>
              <IconButton
                onClick={isListening ? stopListening : startListening}
                disabled={disabled || isLoading}
                sx={{
                  width: 48,
                  height: 48,
                  borderRadius: 2,
                  background: isListening ? '#ef4444' : 'transparent',
                  color: isListening ? 'white' : 'text.primary',
                  animation: isListening ? 'pulse 1.5s infinite' : 'none',
                  '@keyframes pulse': {
                    '0%': { boxShadow: '0 0 0 0 rgba(239, 68, 68, 0.4)' },
                    '70%': { boxShadow: '0 0 0 10px rgba(239, 68, 68, 0)' },
                    '100%': { boxShadow: '0 0 0 0 rgba(239, 68, 68, 0)' },
                  },
                  '&:hover': {
                    background: isListening ? '#dc2626' : 'action.hover',
                  },
                }}
              >
                {isListening ? <Stop /> : <Mic />}
              </IconButton>
            </Tooltip>
          )}

          <Tooltip title="Send message">
            <span>
              <IconButton
                type="submit"
                disabled={!message.trim() || isLoading || disabled}
                sx={{
                  width: 48,
                  height: 48,
                  borderRadius: 2,
                  background: 'linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%)',
                  color: 'white',
                  '&:hover': {
                    background: 'linear-gradient(135deg, #2563eb 0%, #7c3aed 100%)',
                  },
                  '&.Mui-disabled': {
                    background: theme.palette.action.disabledBackground,
                    color: theme.palette.action.disabled,
                  },
                }}
              >
                {isLoading ? <CircularProgress size={24} color="inherit" /> : <Send />}
              </IconButton>
            </span>
          </Tooltip>
        </Box>
      </Box>
    </Paper>
  );
};

export default ChatInput;
