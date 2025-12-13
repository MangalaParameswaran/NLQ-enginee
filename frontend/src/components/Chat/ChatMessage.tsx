import React, { useState } from 'react';
import {
  Box,
  Paper,
  Typography,
  IconButton,
  Collapse,
  Chip,
  Rating,
  TextField,
  Button,
  useTheme,
} from '@mui/material';
import {
  Person,
  SmartToy,
  ExpandMore,
  ExpandLess,
  Code,
  ContentCopy,
} from '@mui/icons-material';
import ChartRenderer from '../Charts/ChartRenderer';

interface Message {
  id: number;
  role: 'user' | 'assistant';
  content: string;
  query_type?: string;
  generated_query?: string;
  chart_type?: string;
  chart_data?: string;
  insights?: string;
  user_rating?: number;
  execution_time_ms?: number;
  created_at: string;
}

interface ChatMessageProps {
  message: Message;
  onFeedback?: (messageId: number, rating: number, feedback?: string) => void;
}

const ChatMessage: React.FC<ChatMessageProps> = ({ message, onFeedback }) => {
  const theme = useTheme();
  const [showQuery, setShowQuery] = useState(false);
  const [rating, setRating] = useState(message.user_rating || 0);
  const [feedback, setFeedback] = useState('');
  const [showFeedback, setShowFeedback] = useState(false);

  const isUser = message.role === 'user';

  const chartData = message.chart_data ? JSON.parse(message.chart_data) : null;
  const insights = message.insights ? JSON.parse(message.insights) : null;

  const handleCopy = (text: string) => {
    navigator.clipboard.writeText(text);
  };

  const handleRatingSubmit = () => {
    if (onFeedback && rating > 0) {
      onFeedback(message.id, rating, feedback || undefined);
      setShowFeedback(false);
    }
  };

  return (
    <Box
      sx={{
        display: 'flex',
        justifyContent: isUser ? 'flex-end' : 'flex-start',
        mb: 2,
        px: 2,
      }}
    >
      <Box
        sx={{
          display: 'flex',
          flexDirection: isUser ? 'row-reverse' : 'row',
          gap: 1.5,
          maxWidth: '85%',
        }}
      >
        <Box
          sx={{
            width: 36,
            height: 36,
            borderRadius: 2,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            background: isUser
              ? 'linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%)'
              : theme.palette.mode === 'dark'
              ? 'rgba(255,255,255,0.1)'
              : 'rgba(0,0,0,0.08)',
            flexShrink: 0,
          }}
        >
          {isUser ? (
            <Person sx={{ color: 'white', fontSize: 20 }} />
          ) : (
            <SmartToy sx={{ color: theme.palette.primary.main, fontSize: 20 }} />
          )}
        </Box>

        <Paper
          elevation={0}
          sx={{
            p: 2,
            borderRadius: 3,
            background: isUser
              ? 'linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%)'
              : theme.palette.mode === 'dark'
              ? 'rgba(255,255,255,0.05)'
              : 'rgba(0,0,0,0.03)',
            color: isUser ? 'white' : 'inherit',
          }}
        >
          <Typography variant="body1" sx={{ whiteSpace: 'pre-wrap' }}>
            {message.content}
          </Typography>

          {!isUser && message.generated_query && (
            <Box sx={{ mt: 2 }}>
              <Button
                size="small"
                startIcon={<Code />}
                endIcon={showQuery ? <ExpandLess /> : <ExpandMore />}
                onClick={() => setShowQuery(!showQuery)}
                sx={{ mb: 1 }}
              >
                {showQuery ? 'Hide Query' : 'Show Query'}
              </Button>
              <Collapse in={showQuery}>
                <Paper
                  sx={{
                    p: 2,
                    borderRadius: 2,
                    background: theme.palette.mode === 'dark' ? '#1e1e1e' : '#f5f5f5',
                    position: 'relative',
                  }}
                >
                  <IconButton
                    size="small"
                    onClick={() => handleCopy(message.generated_query || '')}
                    sx={{ position: 'absolute', top: 8, right: 8 }}
                  >
                    <ContentCopy fontSize="small" />
                  </IconButton>
                  <Typography
                    component="pre"
                    sx={{
                      fontFamily: 'monospace',
                      fontSize: 13,
                      overflow: 'auto',
                      m: 0,
                      color: theme.palette.text.primary,
                    }}
                  >
                    {message.generated_query}
                  </Typography>
                </Paper>
              </Collapse>
            </Box>
          )}

          {!isUser && chartData && chartData.data && chartData.data.length > 0 && (
            <Box sx={{ mt: 2 }}>
              <ChartRenderer
                type={message.chart_type || 'table'}
                data={chartData.data}
                config={chartData.config || {}}
              />
            </Box>
          )}

          {!isUser && insights && insights.length > 0 && (
            <Box sx={{ mt: 2 }}>
              <Typography variant="subtitle2" gutterBottom>
                Key Insights
              </Typography>
              <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 1 }}>
                {insights.map((insight: { title: string; importance: string }, index: number) => (
                  <Chip
                    key={index}
                    label={insight.title}
                    size="small"
                    color={insight.importance === 'high' ? 'primary' : 'default'}
                    variant="outlined"
                  />
                ))}
              </Box>
            </Box>
          )}

          {!isUser && message.execution_time_ms && (
            <Typography variant="caption" sx={{ display: 'block', mt: 1, opacity: 0.7 }}>
              Executed in {message.execution_time_ms.toFixed(0)}ms
            </Typography>
          )}

          {!isUser && onFeedback && (
            <Box sx={{ mt: 2, pt: 1, borderTop: `1px solid ${theme.palette.divider}` }}>
              <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                <Typography variant="caption">Was this helpful?</Typography>
                <Rating
                  size="small"
                  value={rating}
                  onChange={(_, value) => {
                    setRating(value || 0);
                    setShowFeedback(true);
                  }}
                />
              </Box>
              <Collapse in={showFeedback && rating > 0}>
                <Box sx={{ mt: 1 }}>
                  <TextField
                    size="small"
                    fullWidth
                    placeholder="Any feedback? (optional)"
                    value={feedback}
                    onChange={(e) => setFeedback(e.target.value)}
                    sx={{ mb: 1 }}
                  />
                  <Button size="small" variant="contained" onClick={handleRatingSubmit}>
                    Submit Feedback
                  </Button>
                </Box>
              </Collapse>
            </Box>
          )}
        </Paper>
      </Box>
    </Box>
  );
};

export default ChatMessage;
