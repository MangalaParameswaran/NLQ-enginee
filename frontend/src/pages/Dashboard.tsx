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
  Button,
  Collapse,
} from '@mui/material';
import { Lightbulb, ExpandMore, ExpandLess, Download as DownloadIcon } from '@mui/icons-material';
import Header from '../components/Layout/Header';
import Sidebar from '../components/Layout/Sidebar';
import ChatInput from '../components/Chat/ChatInput';
import type { OutputPreference } from '../components/Chat/ChatInput';
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
  const [showSamples, setShowSamples] = useState(false);
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



  const isTrendQuery = (query: string): boolean => {
    const lowerQuery = query.toLowerCase();
    return ['trend', 'over time', 'last month', 'last week', 'last year', 'over the last', 'monthly', 'weekly', 'daily', 'growth', 'progression', 'history'].some(k => lowerQuery.includes(k));
  };

  const hasTimeBasedData = (data: Record<string, unknown>[]): { hasTime: boolean; timeColumn?: string } => {
    if (!data || data.length === 0) return { hasTime: false };
    const columns = Object.keys(data[0]);
    const timePatterns = ['date', 'month', 'week', 'year', 'day', 'time', 'period', 'quarter', 'created', 'updated'];
    const timeColumn = columns.find(col => timePatterns.some(p => col.toLowerCase().includes(p)));
    return { hasTime: !!timeColumn && data.length > 1, timeColumn };
  };

  const handleSendMessage = async (message: string, outputPreference: OutputPreference) => {
    setIsLoading(true);
    setCurrentOutputPreference(outputPreference);
    setShowSamples(false);

    const tempUserMessage: Message = {
      id: Date.now(),
      role: 'user',
      content: message,
      created_at: new Date().toISOString(),
    };
    setMessages((prev) => [...prev, tempUserMessage]);
    // Validation removed to allow NLP queries

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

        if ((data as any).error) {
          throw new Error((data as any).error);
        }

        const resultData = (data.result?.data || []) as Record<string, unknown>[];
        let effectiveChartType = data.chart?.chart_type || 'table';
        let effectiveOutputPref = outputPreference;
        let contentMessage = data.explanation || 'Here are your results.';

        const isTrend = isTrendQuery(message);
        const timeCheck = hasTimeBasedData(resultData);

        if (isTrend && !timeCheck.hasTime) {
          if (resultData.length <= 1) {
            contentMessage = `The query returned ${resultData.length === 0 ? 'no data' : 'only a single aggregated value'}, which is not sufficient to show a trend.\n\nTo see a trend, the data needs multiple time-based data points (e.g., by month, week, or day).\n\n**Options:**\n- View as **Table** to see the current value\n- View as **Insights** for a summary\n- Try rephrasing with time grouping: "Show monthly orders for the last 6 months"`;
            effectiveOutputPref = 'insights';
            effectiveChartType = 'table';
          } else if (!timeCheck.timeColumn) {
            contentMessage = `The data doesn't contain a time-based column (like date, month, or week) needed to show a trend.\n\n**Suggestions:**\n- Try: "Show orders grouped by month"\n- Or: "Show sales by week for the last 3 months"\n\nCurrently showing your results as a table.`;
            effectiveOutputPref = 'table';
            effectiveChartType = 'table';
          }
        } else if (outputPreference === 'chart' && resultData.length > 0) {
          const columns = Object.keys(resultData[0]);
          const numericCols = columns.filter(k => typeof resultData[0][k] === 'number');
          if (numericCols.length === 0 || resultData.length < 2) {
            effectiveChartType = 'table';
            effectiveOutputPref = 'table';
          }
        }

        const assistantMessage: Message = {
          id: data.message_id,
          role: 'assistant',
          content: contentMessage,
          generated_query: data.generated_query?.sql,
          chart_type: effectiveOutputPref === 'table' ? 'table' : effectiveChartType,
          chart_data: JSON.stringify({
            data: resultData,
            config: data.chart || {},
          }),
          insights: JSON.stringify(data.insights || []),
          created_at: new Date().toISOString(),
          outputPreference: effectiveOutputPref,
        };
        setMessages((prev) => [...prev, assistantMessage]);
      } else {
        throw new Error(response.error || 'Failed to process query');
      }
    } catch (error: unknown) {
      const errorMessage = error instanceof Error ? error.message : 'An error occurred';
      const suggestions = sampleQuestions.slice(0, 3).map(q => q.question).join('\n- ');
      const assistantMessage: Message = {
        id: Date.now() + 1,
        role: 'assistant',
        content: `Sorry, I couldn't process that query. ${errorMessage}\n\nTry these sample questions:\n- ${suggestions}`,
        created_at: new Date().toISOString(),
        outputPreference: 'insights',
      };
      setMessages((prev) => [...prev, assistantMessage]);
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

  const downloadAllReports = (format: 'csv' | 'pdf') => {
    const allData: Record<string, unknown>[] = [];
    messages.forEach(msg => {
      if (msg.role === 'assistant' && msg.chart_data) {
        try {
          const parsed = JSON.parse(msg.chart_data);
          if (parsed.data && Array.isArray(parsed.data)) {
            allData.push(...parsed.data);
          }
        } catch { }
      }
    });

    if (allData.length === 0) {
      setSnackbar({ open: true, message: 'No data to download', severity: 'error' });
      return;
    }

    if (format === 'csv') {
      const headers = Object.keys(allData[0]);
      const csvContent = [
        headers.join(','),
        ...allData.map(row =>
          headers.map(h => {
            const val = row[h];
            if (typeof val === 'string' && val.includes(',')) {
              return `"${val}"`;
            }
            return val;
          }).join(',')
        )
      ].join('\n');

      const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
      const link = document.createElement('a');
      link.href = URL.createObjectURL(blob);
      link.download = `all_reports_${new Date().toISOString().slice(0, 10)}.csv`;
      link.click();
      URL.revokeObjectURL(link.href);
    } else {
      const headers = Object.keys(allData[0]);
      const htmlContent = `
        <!DOCTYPE html>
        <html>
        <head>
          <title>All Reports</title>
          <style>
            body { font-family: Arial, sans-serif; padding: 20px; }
            h1 { color: #333; font-size: 18px; }
            table { width: 100%; border-collapse: collapse; margin-top: 20px; }
            th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
            th { background-color: #3b82f6; color: white; }
            tr:nth-child(even) { background-color: #f9f9f9; }
            .meta { color: #666; font-size: 12px; margin-bottom: 20px; }
          </style>
        </head>
        <body>
          <h1>All Query Results</h1>
          <div class="meta">Generated on ${new Date().toLocaleString()} | ${allData.length} records</div>
          <table>
            <thead>
              <tr>${headers.map(h => `<th>${h}</th>`).join('')}</tr>
            </thead>
            <tbody>
              ${allData.map(row =>
        `<tr>${headers.map(h => `<td>${row[h] ?? ''}</td>`).join('')}</tr>`
      ).join('')}
            </tbody>
          </table>
        </body>
        </html>
      `;

      const printWindow = window.open('', '_blank');
      if (printWindow) {
        printWindow.document.write(htmlContent);
        printWindow.document.close();
        printWindow.print();
      }
    }
    setSnackbar({ open: true, message: `Downloaded all reports as ${format.toUpperCase()}`, severity: 'success' });
  };

  const renderSampleQuestions = () => (
    <Box sx={{ maxWidth: 800, mx: 'auto', mb: 2 }}>
      <Button
        size="small"
        onClick={() => setShowSamples(!showSamples)}
        startIcon={<Lightbulb />}
        endIcon={showSamples ? <ExpandLess /> : <ExpandMore />}
        sx={{ mb: 1 }}
      >
        {showSamples ? 'Hide suggestions' : 'Show sample questions'}
      </Button>
      <Collapse in={showSamples}>
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
      </Collapse>
    </Box>
  );

  const hasDownloadableData = messages.some(msg => msg.role === 'assistant' && msg.chart_data);

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
              {hasDownloadableData && (
                <Box sx={{ display: 'flex', justifyContent: 'flex-end', gap: 1, mb: 2, px: 2 }}>
                  <Button
                    size="small"
                    variant="outlined"
                    startIcon={<DownloadIcon />}
                    onClick={() => downloadAllReports('csv')}
                  >
                    Download All (CSV)
                  </Button>
                  <Button
                    size="small"
                    variant="outlined"
                    startIcon={<DownloadIcon />}
                    onClick={() => downloadAllReports('pdf')}
                  >
                    Download All (PDF)
                  </Button>
                </Box>
              )}

              {sampleQuestions.length > 0 && renderSampleQuestions()}

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
