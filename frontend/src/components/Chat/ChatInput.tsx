import React, { useState, useEffect } from 'react';
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
} from '@mui/material';
import { Send, Mic, Stop, Insights, TableChart, BarChart, Download } from '@mui/icons-material';
import { useSpeechRecognition } from '../../hooks/useSpeechRecognition';

export type OutputPreference = 'insights' | 'table' | 'chart' | 'download';

interface ChatInputProps {
  onSend: (message: string, outputPreference: OutputPreference) => void;
  isLoading: boolean;
  disabled?: boolean;
}

const ChatInput: React.FC<ChatInputProps> = ({ onSend, isLoading, disabled }) => {
  const theme = useTheme();
  const [message, setMessage] = useState('');
  const [outputPreference, setOutputPreference] = useState<OutputPreference>('chart');
  const { transcript, isListening, isSupported, startListening, stopListening, resetTranscript } =
    useSpeechRecognition();

  useEffect(() => {
    if (transcript) {
      setMessage(transcript);
    }
  }, [transcript]);

  const handleSubmit = (e?: React.FormEvent) => {
    e?.preventDefault();
    const trimmedMessage = message.trim();
    if (trimmedMessage && !isLoading && !disabled) {
      onSend(trimmedMessage, outputPreference);
      setMessage('');
      resetTranscript();
    }
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSubmit();
    }
  };

  const toggleVoice = () => {
    if (isListening) {
      stopListening();
    } else {
      startListening();
    }
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
                onClick={toggleVoice}
                disabled={disabled || isLoading}
                sx={{
                  width: 48,
                  height: 48,
                  borderRadius: 2,
                  background: isListening ? 'error.main' : 'transparent',
                  color: isListening ? 'white' : 'text.primary',
                  '&:hover': {
                    background: isListening ? 'error.dark' : 'action.hover',
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
