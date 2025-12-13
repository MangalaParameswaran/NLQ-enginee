import React, { useState, useEffect } from 'react';
import {
  Box,
  TextField,
  IconButton,
  Paper,
  Tooltip,
  CircularProgress,
  useTheme,
} from '@mui/material';
import { Send, Mic, Stop } from '@mui/icons-material';
import { useSpeechRecognition } from '../../hooks/useSpeechRecognition';

interface ChatInputProps {
  onSend: (message: string) => void;
  isLoading: boolean;
  disabled?: boolean;
}

const ChatInput: React.FC<ChatInputProps> = ({ onSend, isLoading, disabled }) => {
  const theme = useTheme();
  const [message, setMessage] = useState('');
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
      onSend(trimmedMessage);
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

  return (
    <Paper
      elevation={0}
      sx={{
        p: 2,
        borderTop: `1px solid ${theme.palette.divider}`,
        background: theme.palette.background.paper,
      }}
    >
      <Box
        component="form"
        onSubmit={handleSubmit}
        sx={{
          display: 'flex',
          alignItems: 'flex-end',
          gap: 1,
          maxWidth: 900,
          mx: 'auto',
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
    </Paper>
  );
};

export default ChatInput;
