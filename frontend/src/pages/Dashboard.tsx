import React, { useState, useEffect, useRef } from 'react';
import {
  Box,
  Typography,
  Paper,
  Chip,
  Skeleton,
  useTheme,
  Snackbar,
  Alert,
} from '@mui/material';
import { Lightbulb } from '@mui/icons-material';
import Header from '../components/Layout/Header';
import Sidebar from '../components/Layout/Sidebar';
import ChatInput, { OutputPreference } from '../components/Chat/ChatInput';
import ChatMessage from '../components/Chat/ChatMessage';
import { apiClient } from '../services/api';

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
  outputPreference?: string;
}

interface Conversation {
  id: number;
  title: string;
  created_at: string;
  message_count: number;
}

interface SampleQuestion {
  question: string;
  category: string;
  description: string;
}

const Dashboard: React.FC = () => {
  const theme = useTheme();
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [conversations, setConversations] = useState<Conversation[]>([]);
  const [selectedConversation, setSelectedConversation] = useState<number | null>(null);
  const [messages, setMessages] = useState<Message[]>([]);
  const [sampleQuestions, setSampleQuestions] = useState<SampleQuestion[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [currentOutputPreference, setCurrentOutputPreference] = useState<OutputPreference>('chart');
  const [snackbar, setSnackbar] = useState<{ open: boolean; message: string; severity: 'success' | 'error' }>({
    open: false,
    message: '',
    severity: 'success',
  });

  useEffect(() => {
    loadConversations();
    loadSampleQuestions();
  }, []);

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  const loadConversations = async () => {
    const response = await apiClient.post({
      service: 'conversation',
      action: 'get_conversations',
      payload: { limit: 50 },
    });
    if (response.success && response.data) {
      setConversations(response.data as Conversation[]);
    }
  };

  const loadSampleQuestions = async () => {
    const response = await apiClient.post({
      service: 'query',
      action: 'get_sample_questions',
      payload: {},
    });
    if (response.success && response.data) {
      setSampleQuestions(response.data as SampleQuestion[]);
    }
  };

  const loadConversation = async (conversationId: number) => {
    setSelectedConversation(conversationId);
    const response = await apiClient.post({
      service: 'conversation',
      action: 'get_conversation',
      payload: { conversation_id: conversationId },
    });
    if (response.success && response.data) {
      const data = response.data as { messages: Message[] };
      setMessages(data.messages || []);
    }
  };

  const handleNewConversation = () => {
    setSelectedConversation(null);
    setMessages([]);
    setSidebarOpen(false);
  };

  const handleDeleteConversation = async (conversationId: number) => {
    const response = await apiClient.post({
      service: 'conversation',
      action: 'delete_conversation',
      payload: { conversation_id: conversationId },
    });
    if (response.success) {
      if (selectedConversation === conversationId) {
        handleNewConversation();
      }
      loadConversations();
    }
  };

  const handleSendMessage = async (message: string, outputPreference: OutputPreference) => {
    setIsLoading(true);
    setCurrentOutputPreference(outputPreference);

    const tempUserMessage: Message = {
      id: Date.now(),
      role: 'user',
      content: message,
      created_at: new Date().toISOString(),
    };
    setMessages((prev) => [...prev, tempUserMessage]);

    try {
      const response = await apiClient.post({
        service: 'query',
        action: 'execute_query',
        payload: {
          query: message,
          conversation_id: selectedConversation,
        },
      });

      if (response.success && response.data) {
        const data = response.data as {
          conversation_id: number;
          message_id: number;
          explanation: string;
          generated_query: { sql?: string };
          chart: { chart_type: string };
          result: { data: unknown[] };
          insights: unknown[];
        };
        
        if (!selectedConversation && data.conversation_id) {
          setSelectedConversation(data.conversation_id);
          loadConversations();
        }

        const assistantMessage: Message = {
          id: data.message_id,
          role: 'assistant',
          content: data.explanation || 'Here are your results.',
          generated_query: data.generated_query?.sql,
          chart_type: outputPreference === 'table' ? 'table' : (data.chart?.chart_type || 'table'),
          chart_data: JSON.stringify({
            data: data.result?.data || [],
            config: data.chart || {},
          }),
          insights: JSON.stringify(data.insights || []),
          created_at: new Date().toISOString(),
          outputPreference: outputPreference,
        };
        setMessages((prev) => [...prev, assistantMessage]);
      } else {
        throw new Error(response.error || 'Failed to process query');
      }
    } catch (error: unknown) {
      const errorMessage = error instanceof Error ? error.message : 'An error occurred';
      setSnackbar({
        open: true,
        message: errorMessage,
        severity: 'error',
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleFeedback = async (messageId: number, rating: number, feedback?: string) => {
    const response = await apiClient.post({
      service: 'feedback',
      action: 'submit_feedback',
      payload: { message_id: messageId, rating, feedback },
    });
    if (response.success) {
      setSnackbar({
        open: true,
        message: 'Thank you for your feedback!',
        severity: 'success',
      });
    }
  };

  const handleSampleClick = (question: string) => {
    handleSendMessage(question, currentOutputPreference);
  };

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', height: '100vh' }}>
      <Header onMenuClick={() => setSidebarOpen(true)} />
      
      <Sidebar
        open={sidebarOpen}
        onClose={() => setSidebarOpen(false)}
        conversations={conversations}
        selectedConversation={selectedConversation}
        onSelectConversation={(id) => {
          loadConversation(id);
          setSidebarOpen(false);
        }}
        onNewConversation={handleNewConversation}
        onDeleteConversation={handleDeleteConversation}
      />

      <Box
        sx={{
          flex: 1,
          display: 'flex',
          flexDirection: 'column',
          mt: 8,
          overflow: 'hidden',
        }}
      >
        <Box
          sx={{
            flex: 1,
            overflow: 'auto',
            py: 2,
          }}
        >
          {messages.length === 0 ? (
            <Box
              sx={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                height: '100%',
                px: 3,
              }}
            >
              <Box
                sx={{
                  width: 80,
                  height: 80,
                  borderRadius: 4,
                  background: 'linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  mb: 3,
                }}
              >
                <Typography variant="h3" sx={{ color: 'white', fontWeight: 700 }}>
                  N
                </Typography>
              </Box>
              <Typography variant="h4" fontWeight={700} gutterBottom textAlign="center">
                Ask anything about your data
              </Typography>
              <Typography
                variant="body1"
                color="text.secondary"
                textAlign="center"
                sx={{ maxWidth: 500, mb: 4 }}
              >
                Use natural language to query your databases, generate insights, and create visualizations.
              </Typography>

              {sampleQuestions.length > 0 && (
                <Box sx={{ maxWidth: 800 }}>
                  <Typography
                    variant="subtitle2"
                    color="text.secondary"
                    sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 2 }}
                  >
                    <Lightbulb fontSize="small" />
                    Try asking:
                  </Typography>
                  <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 1, justifyContent: 'center' }}>
                    {sampleQuestions.map((sample, index) => (
                      <Chip
                        key={index}
                        label={sample.question}
                        onClick={() => handleSampleClick(sample.question)}
                        sx={{
                          cursor: 'pointer',
                          borderRadius: 3,
                          py: 2.5,
                          '&:hover': {
                            background: theme.palette.action.hover,
                          },
                        }}
                      />
                    ))}
                  </Box>
                </Box>
              )}
            </Box>
          ) : (
            <Box sx={{ maxWidth: 900, mx: 'auto' }}>
              {messages.map((message) => (
                <ChatMessage
                  key={message.id}
                  message={message}
                  onFeedback={message.role === 'assistant' ? handleFeedback : undefined}
                />
              ))}
              {isLoading && (
                <Box sx={{ px: 2, mb: 2 }}>
                  <Paper
                    elevation={0}
                    sx={{
                      p: 2,
                      borderRadius: 3,
                      background: theme.palette.mode === 'dark'
                        ? 'rgba(255,255,255,0.05)'
                        : 'rgba(0,0,0,0.03)',
                      maxWidth: '85%',
                    }}
                  >
                    <Skeleton animation="wave" height={24} width="80%" />
                    <Skeleton animation="wave" height={24} width="60%" />
                    <Skeleton animation="wave" height={200} sx={{ mt: 2, borderRadius: 2 }} />
                  </Paper>
                </Box>
              )}
              <div ref={messagesEndRef} />
            </Box>
          )}
        </Box>

        <ChatInput onSend={handleSendMessage} isLoading={isLoading} />
      </Box>

      <Snackbar
        open={snackbar.open}
        autoHideDuration={4000}
        onClose={() => setSnackbar({ ...snackbar, open: false })}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}
      >
        <Alert severity={snackbar.severity} sx={{ borderRadius: 2 }}>
          {snackbar.message}
        </Alert>
      </Snackbar>
    </Box>
  );
};

export default Dashboard;
