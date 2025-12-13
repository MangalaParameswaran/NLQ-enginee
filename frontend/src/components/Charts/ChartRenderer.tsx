import React, { useState } from 'react';
import { Box, Paper, Typography, useTheme, ToggleButtonGroup, ToggleButton, Alert } from '@mui/material';
import { BarChart as BarChartIcon, ShowChart, PieChart as PieChartIcon, AreaChart as AreaChartIcon, TableChart } from '@mui/icons-material';
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
  summary?: string;
}

interface ChartRendererProps {
  type: string;
  data: Record<string, unknown>[];
  config: ChartConfig;
  onChartTypeChange?: (newType: string) => void;
  showFallbackSuggestion?: boolean;
}

const COLORS = ['#3b82f6', '#8b5cf6', '#10b981', '#f59e0b', '#ef4444', '#06b6d4', '#ec4899'];

const ChartRenderer: React.FC<ChartRendererProps> = ({ type, data, config, onChartTypeChange, showFallbackSuggestion }) => {
  const theme = useTheme();
  const [selectedChartType, setSelectedChartType] = useState(type.toLowerCase());

  if (!data || data.length === 0) {
    return (
      <Paper sx={{ p: 3, textAlign: 'center' }}>
        <Typography color="text.secondary">No data available</Typography>
      </Paper>
    );
  }

  const columns = Object.keys(data[0]);
  const numericColumns = columns.filter(k => {
    const val = data[0][k];
    return typeof val === 'number' || (typeof val === 'string' && !isNaN(Number(val)));
  });
  
  const hasValidChartData = numericColumns.length > 0 && data.length > 1;
  const canShowChart = hasValidChartData && selectedChartType !== 'table';

  const xKey = config.x_axis || columns[0];
  const yKeys = Array.isArray(config.y_axis) 
    ? config.y_axis 
    : config.y_axis 
      ? [config.y_axis] 
      : numericColumns.length > 0 ? numericColumns : [columns[1] || columns[0]];

  const chartColors = config.colors || COLORS;

  const handleChartTypeChange = (_: React.MouseEvent<HTMLElement>, newType: string | null) => {
    if (newType) {
      setSelectedChartType(newType);
      onChartTypeChange?.(newType);
    }
  };

  const generateSummary = () => {
    if (config.summary) return config.summary;
    
    const rowCount = data.length;
    const colCount = columns.length;
    
    if (numericColumns.length > 0) {
      const numCol = numericColumns[0];
      const values = data.map(d => Number(d[numCol])).filter(v => !isNaN(v));
      if (values.length > 0) {
        const total = values.reduce((a, b) => a + b, 0);
        const avg = total / values.length;
        const max = Math.max(...values);
        const min = Math.min(...values);
        return `${rowCount} records with ${colCount} columns. ${numCol}: Total ${total.toLocaleString()}, Avg ${avg.toFixed(2)}, Range ${min.toLocaleString()} - ${max.toLocaleString()}`;
      }
    }
    return `Showing ${rowCount} records across ${colCount} columns`;
  };

  const renderChart = () => {
    if (!canShowChart && selectedChartType !== 'table') {
      return (
        <Box>
          {showFallbackSuggestion && (
            <Alert severity="info" sx={{ mb: 2 }}>
              Chart visualization not available for this data. Showing as table instead.
            </Alert>
          )}
          {renderTable()}
        </Box>
      );
    }

    switch (selectedChartType) {
      case 'bar':
        return (
          <ResponsiveContainer width="100%" height={350}>
            <BarChart data={data} margin={{ top: 20, right: 30, left: 20, bottom: 60 }}>
              <CartesianGrid strokeDasharray="3 3" stroke={theme.palette.divider} />
              <XAxis 
                dataKey={xKey} 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary, fontSize: 12 }}
                angle={-45}
                textAnchor="end"
                height={80}
              />
              <YAxis 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary, fontSize: 12 }}
              />
              <Tooltip 
                contentStyle={{ 
                  background: theme.palette.background.paper,
                  border: `1px solid ${theme.palette.divider}`,
                  borderRadius: 8,
                  boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
                }}
              />
              <Legend wrapperStyle={{ paddingTop: 20 }} />
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
          <ResponsiveContainer width="100%" height={350}>
            <LineChart data={data} margin={{ top: 20, right: 30, left: 20, bottom: 60 }}>
              <CartesianGrid strokeDasharray="3 3" stroke={theme.palette.divider} />
              <XAxis 
                dataKey={xKey} 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary, fontSize: 12 }}
                angle={-45}
                textAnchor="end"
                height={80}
              />
              <YAxis 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary, fontSize: 12 }}
              />
              <Tooltip 
                contentStyle={{ 
                  background: theme.palette.background.paper,
                  border: `1px solid ${theme.palette.divider}`,
                  borderRadius: 8,
                  boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
                }}
              />
              <Legend wrapperStyle={{ paddingTop: 20 }} />
              {yKeys.map((key, index) => (
                <Line 
                  key={key}
                  type="monotone"
                  dataKey={key}
                  stroke={chartColors[index % chartColors.length]}
                  strokeWidth={3}
                  dot={{ r: 5, strokeWidth: 2 }}
                  activeDot={{ r: 7 }}
                />
              ))}
            </LineChart>
          </ResponsiveContainer>
        );

      case 'pie':
        const pieData = data.slice(0, 8);
        return (
          <ResponsiveContainer width="100%" height={350}>
            <PieChart>
              <Pie
                data={pieData}
                dataKey={yKeys[0] || 'value'}
                nameKey={xKey}
                cx="50%"
                cy="50%"
                outerRadius={120}
                innerRadius={60}
                label={({ name, percent }) => `${name}: ${((percent || 0) * 100).toFixed(0)}%`}
                labelLine={{ strokeWidth: 2 }}
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
                  boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
                }}
              />
              <Legend />
            </PieChart>
          </ResponsiveContainer>
        );

      case 'area':
        return (
          <ResponsiveContainer width="100%" height={350}>
            <AreaChart data={data} margin={{ top: 20, right: 30, left: 20, bottom: 60 }}>
              <CartesianGrid strokeDasharray="3 3" stroke={theme.palette.divider} />
              <XAxis 
                dataKey={xKey} 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary, fontSize: 12 }}
                angle={-45}
                textAnchor="end"
                height={80}
              />
              <YAxis 
                stroke={theme.palette.text.secondary}
                tick={{ fill: theme.palette.text.secondary, fontSize: 12 }}
              />
              <Tooltip 
                contentStyle={{ 
                  background: theme.palette.background.paper,
                  border: `1px solid ${theme.palette.divider}`,
                  borderRadius: 8,
                  boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
                }}
              />
              <Legend wrapperStyle={{ paddingTop: 20 }} />
              {yKeys.map((key, index) => (
                <Area 
                  key={key}
                  type="monotone"
                  dataKey={key}
                  stroke={chartColors[index % chartColors.length]}
                  fill={chartColors[index % chartColors.length]}
                  fillOpacity={0.3}
                  strokeWidth={2}
                />
              ))}
            </AreaChart>
          </ResponsiveContainer>
        );

      case 'table':
      default:
        return renderTable();
    }
  };

  const renderTable = () => {
    const displayColumns = columns.filter(col => !col.startsWith('?column?'));
    const cleanData = data.map(row => {
      const cleanRow: Record<string, unknown> = {};
      displayColumns.forEach(col => {
        cleanRow[col] = row[col];
      });
      if (displayColumns.length === 0) {
        Object.entries(row).forEach(([key, value], index) => {
          const cleanKey = key.startsWith('?column?') ? `Column ${index + 1}` : key;
          cleanRow[cleanKey] = value;
        });
      }
      return cleanRow;
    });
    const finalColumns = displayColumns.length > 0 ? displayColumns : Object.keys(cleanData[0] || {});

    return (
      <Box sx={{ overflow: 'auto', maxHeight: 400 }}>
        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
          <thead>
            <tr>
              {finalColumns.map((col) => (
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
                    position: 'sticky',
                    top: 0,
                  }}
                >
                  {col}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {cleanData.slice(0, 100).map((row, rowIndex) => (
              <tr key={rowIndex} style={{ background: rowIndex % 2 === 0 ? 'transparent' : (theme.palette.mode === 'dark' ? 'rgba(255,255,255,0.02)' : 'rgba(0,0,0,0.01)') }}>
                {finalColumns.map((col) => (
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
        <Typography variant="h6" gutterBottom fontWeight={600}>
          {config.title}
        </Typography>
      )}
      
      <Box sx={{ mb: 2, p: 1.5, borderRadius: 1, background: theme.palette.mode === 'dark' ? 'rgba(59,130,246,0.1)' : 'rgba(59,130,246,0.05)', border: `1px solid ${theme.palette.mode === 'dark' ? 'rgba(59,130,246,0.3)' : 'rgba(59,130,246,0.2)'}` }}>
        <Typography variant="body2" color="text.secondary">
          {generateSummary()}
        </Typography>
      </Box>

      {hasValidChartData && (
        <Box sx={{ mb: 2, display: 'flex', justifyContent: 'center' }}>
          <ToggleButtonGroup
            value={selectedChartType}
            exclusive
            onChange={handleChartTypeChange}
            size="small"
            sx={{
              '& .MuiToggleButton-root': {
                px: 2,
                py: 0.5,
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
            <ToggleButton value="bar">
              <BarChartIcon sx={{ fontSize: 18, mr: 0.5 }} />
              Bar
            </ToggleButton>
            <ToggleButton value="line">
              <ShowChart sx={{ fontSize: 18, mr: 0.5 }} />
              Line
            </ToggleButton>
            <ToggleButton value="pie">
              <PieChartIcon sx={{ fontSize: 18, mr: 0.5 }} />
              Pie
            </ToggleButton>
            <ToggleButton value="area">
              <AreaChartIcon sx={{ fontSize: 18, mr: 0.5 }} />
              Area
            </ToggleButton>
            <ToggleButton value="table">
              <TableChart sx={{ fontSize: 18, mr: 0.5 }} />
              Table
            </ToggleButton>
          </ToggleButtonGroup>
        </Box>
      )}

      {renderChart()}
    </Paper>
  );
};

export default ChartRenderer;
