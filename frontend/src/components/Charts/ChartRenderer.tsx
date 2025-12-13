import React from 'react';
import { Box, Paper, Typography, useTheme } from '@mui/material';
import {
  BarChart,
  Bar,
  LineChart,
  Line,
  PieChart,
  Pie,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  Cell,
} from 'recharts';

interface ChartConfig {
  x_axis?: string;
  y_axis?: string | string[];
  title?: string;
  colors?: string[];
}

interface ChartRendererProps {
  type: string;
  data: Record<string, unknown>[];
  config: ChartConfig;
}

const COLORS = ['#3b82f6', '#8b5cf6', '#10b981', '#f59e0b', '#ef4444', '#06b6d4', '#ec4899'];

const ChartRenderer: React.FC<ChartRendererProps> = ({ type, data, config }) => {
  const theme = useTheme();

  if (!data || data.length === 0) {
    return (
      <Paper sx={{ p: 3, textAlign: 'center' }}>
        <Typography color="text.secondary">No data available</Typography>
      </Paper>
    );
  }

  const xKey = config.x_axis || Object.keys(data[0])[0];
  const yKeys = Array.isArray(config.y_axis) 
    ? config.y_axis 
    : config.y_axis 
      ? [config.y_axis] 
      : Object.keys(data[0]).filter(k => k !== xKey && typeof data[0][k] === 'number');

  const chartColors = config.colors || COLORS;

  const renderChart = () => {
    switch (type.toLowerCase()) {
      case 'bar':
        return (
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={data}>
              <CartesianGrid strokeDasharray="3 3" stroke={theme.palette.divider} />
              <XAxis 
                dataKey={xKey} 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary }}
              />
              <YAxis 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary }}
              />
              <Tooltip 
                contentStyle={{ 
                  background: theme.palette.background.paper,
                  border: `1px solid ${theme.palette.divider}`,
                  borderRadius: 8,
                }}
              />
              <Legend />
              {yKeys.map((key, index) => (
                <Bar 
                  key={key} 
                  dataKey={key} 
                  fill={chartColors[index % chartColors.length]}
                  radius={[4, 4, 0, 0]}
                />
              ))}
            </BarChart>
          </ResponsiveContainer>
        );

      case 'line':
        return (
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={data}>
              <CartesianGrid strokeDasharray="3 3" stroke={theme.palette.divider} />
              <XAxis 
                dataKey={xKey} 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary }}
              />
              <YAxis 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary }}
              />
              <Tooltip 
                contentStyle={{ 
                  background: theme.palette.background.paper,
                  border: `1px solid ${theme.palette.divider}`,
                  borderRadius: 8,
                }}
              />
              <Legend />
              {yKeys.map((key, index) => (
                <Line 
                  key={key}
                  type="monotone"
                  dataKey={key}
                  stroke={chartColors[index % chartColors.length]}
                  strokeWidth={2}
                  dot={{ r: 4 }}
                />
              ))}
            </LineChart>
          </ResponsiveContainer>
        );

      case 'pie':
        const pieData = data.slice(0, 8);
        return (
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={pieData}
                dataKey={yKeys[0] || 'value'}
                nameKey={xKey}
                cx="50%"
                cy="50%"
                outerRadius={100}
                label={({ name, percent }) => `${name}: ${(percent * 100).toFixed(0)}%`}
              >
                {pieData.map((_, index) => (
                  <Cell key={`cell-${index}`} fill={chartColors[index % chartColors.length]} />
                ))}
              </Pie>
              <Tooltip 
                contentStyle={{ 
                  background: theme.palette.background.paper,
                  border: `1px solid ${theme.palette.divider}`,
                  borderRadius: 8,
                }}
              />
              <Legend />
            </PieChart>
          </ResponsiveContainer>
        );

      case 'area':
        return (
          <ResponsiveContainer width="100%" height={300}>
            <AreaChart data={data}>
              <CartesianGrid strokeDasharray="3 3" stroke={theme.palette.divider} />
              <XAxis 
                dataKey={xKey} 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary }}
              />
              <YAxis 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary }}
              />
              <Tooltip 
                contentStyle={{ 
                  background: theme.palette.background.paper,
                  border: `1px solid ${theme.palette.divider}`,
                  borderRadius: 8,
                }}
              />
              <Legend />
              {yKeys.map((key, index) => (
                <Area 
                  key={key}
                  type="monotone"
                  dataKey={key}
                  stroke={chartColors[index % chartColors.length]}
                  fill={chartColors[index % chartColors.length]}
                  fillOpacity={0.3}
                />
              ))}
            </AreaChart>
          </ResponsiveContainer>
        );

      case 'table':
      default:
        const columns = Object.keys(data[0]);
        return (
          <Box sx={{ overflow: 'auto', maxHeight: 400 }}>
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
              <thead>
                <tr>
                  {columns.map((col) => (
                    <th
                      key={col}
                      style={{
                        padding: '12px 16px',
                        textAlign: 'left',
                        borderBottom: `2px solid ${theme.palette.divider}`,
                        background: theme.palette.mode === 'dark' ? 'rgba(255,255,255,0.05)' : 'rgba(0,0,0,0.03)',
                        fontWeight: 600,
                        fontSize: 13,
                        textTransform: 'uppercase',
                        color: theme.palette.text.secondary,
                      }}
                    >
                      {col}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {data.slice(0, 100).map((row, rowIndex) => (
                  <tr key={rowIndex}>
                    {columns.map((col) => (
                      <td
                        key={col}
                        style={{
                          padding: '10px 16px',
                          borderBottom: `1px solid ${theme.palette.divider}`,
                          fontSize: 14,
                        }}
                      >
                        {String(row[col] ?? '')}
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
            {data.length > 100 && (
              <Typography variant="caption" sx={{ p: 2, display: 'block', color: 'text.secondary' }}>
                Showing first 100 of {data.length} rows
              </Typography>
            )}
          </Box>
        );
    }
  };

  return (
    <Paper
      elevation={0}
      sx={{
        p: 2,
        borderRadius: 2,
        background: theme.palette.mode === 'dark' ? 'rgba(255,255,255,0.03)' : 'rgba(0,0,0,0.02)',
      }}
    >
      {config.title && (
        <Typography variant="h6" gutterBottom>
          {config.title}
        </Typography>
      )}
      {renderChart()}
    </Paper>
  );
};

export default ChartRenderer;
