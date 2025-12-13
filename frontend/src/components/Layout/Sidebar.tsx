import React from 'react';
import {
  Box,
  Drawer,
  List,
  ListItem,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Typography,
  IconButton,
  Divider,
  useTheme,
} from '@mui/material';
import {
  Chat as ChatIcon,
  Add as AddIcon,
  Delete as DeleteIcon,
  History as HistoryIcon,
} from '@mui/icons-material';

interface Conversation {
  id: number;
  title: string;
  created_at: string;
  message_count: number;
}

interface SidebarProps {
  open: boolean;
  onClose: () => void;
  conversations: Conversation[];
  selectedConversation: number | null;
  onSelectConversation: (id: number) => void;
  onNewConversation: () => void;
  onDeleteConversation: (id: number) => void;
}

const drawerWidth = 280;

const Sidebar: React.FC<SidebarProps> = ({
  open,
  onClose,
  conversations,
  selectedConversation,
  onSelectConversation,
  onNewConversation,
  onDeleteConversation,
}) => {
  const theme = useTheme();

  const drawerContent = (
    <Box sx={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
      <Box sx={{ p: 2, display: 'flex', alignItems: 'center', gap: 1 }}>
        <Box
          sx={{
            width: 40,
            height: 40,
            borderRadius: 2,
            background: 'linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <ChatIcon sx={{ color: 'white' }} />
        </Box>
        <Typography variant="h6" fontWeight={700}>
          NLQ Engine
        </Typography>
      </Box>

      <Box sx={{ px: 2, pb: 2 }}>
        <ListItemButton
          onClick={onNewConversation}
          sx={{
            borderRadius: 2,
            border: `1px dashed ${theme.palette.divider}`,
            '&:hover': {
              background: theme.palette.action.hover,
            },
          }}
        >
          <ListItemIcon>
            <AddIcon />
          </ListItemIcon>
          <ListItemText primary="New Chat" />
        </ListItemButton>
      </Box>

      <Divider />

      <Box sx={{ flex: 1, overflow: 'auto', px: 1 }}>
        <Typography
          variant="caption"
          sx={{ px: 2, py: 1, display: 'block', color: 'text.secondary' }}
        >
          <HistoryIcon sx={{ fontSize: 14, mr: 0.5, verticalAlign: 'middle' }} />
          Recent Conversations
        </Typography>
        <List>
          {conversations.map((conv) => (
            <ListItem
              key={conv.id}
              disablePadding
              secondaryAction={
                <IconButton
                  edge="end"
                  size="small"
                  onClick={(e) => {
                    e.stopPropagation();
                    onDeleteConversation(conv.id);
                  }}
                  sx={{ opacity: 0.5, '&:hover': { opacity: 1 } }}
                >
                  <DeleteIcon fontSize="small" />
                </IconButton>
              }
            >
              <ListItemButton
                selected={selectedConversation === conv.id}
                onClick={() => onSelectConversation(conv.id)}
                sx={{
                  borderRadius: 2,
                  mx: 1,
                  '&.Mui-selected': {
                    background: theme.palette.action.selected,
                  },
                }}
              >
                <ListItemIcon sx={{ minWidth: 36 }}>
                  <ChatIcon fontSize="small" />
                </ListItemIcon>
                <ListItemText
                  primary={conv.title || 'Untitled'}
                  primaryTypographyProps={{
                    noWrap: true,
                    fontSize: 14,
                  }}
                  secondary={`${conv.message_count} messages`}
                  secondaryTypographyProps={{
                    fontSize: 12,
                  }}
                />
              </ListItemButton>
            </ListItem>
          ))}
          {conversations.length === 0 && (
            <Typography
              variant="body2"
              sx={{ px: 3, py: 2, color: 'text.secondary', textAlign: 'center' }}
            >
              No conversations yet
            </Typography>
          )}
        </List>
      </Box>
    </Box>
  );

  return (
    <Drawer
      variant="temporary"
      open={open}
      onClose={onClose}
      sx={{
        width: drawerWidth,
        flexShrink: 0,
        '& .MuiDrawer-paper': {
          width: drawerWidth,
          boxSizing: 'border-box',
          background: theme.palette.background.paper,
        },
      }}
    >
      {drawerContent}
    </Drawer>
  );
};

export default Sidebar;
