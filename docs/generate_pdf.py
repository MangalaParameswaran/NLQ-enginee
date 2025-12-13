import markdown
from weasyprint import HTML, CSS
from pathlib import Path

md_content = Path('docs/NLQ_Engine_Enterprise_Documentation.md').read_text()

html_content = markdown.markdown(md_content, extensions=['tables', 'fenced_code'])

full_html = f"""
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        @page {{
            size: A4;
            margin: 2cm;
        }}
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            font-size: 11pt;
        }}
        h1 {{
            color: #1a365d;
            border-bottom: 3px solid #2563eb;
            padding-bottom: 10px;
            margin-top: 30px;
            font-size: 24pt;
            page-break-before: always;
        }}
        h1:first-of-type {{
            page-break-before: avoid;
        }}
        h2 {{
            color: #2563eb;
            margin-top: 25px;
            font-size: 16pt;
            border-left: 4px solid #2563eb;
            padding-left: 15px;
        }}
        h3 {{
            color: #4a5568;
            font-size: 13pt;
            margin-top: 20px;
        }}
        table {{
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 10pt;
        }}
        th {{
            background-color: #2563eb;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: 600;
        }}
        td {{
            padding: 10px 12px;
            border-bottom: 1px solid #e2e8f0;
        }}
        tr:nth-child(even) {{
            background-color: #f8fafc;
        }}
        code {{
            background-color: #f1f5f9;
            padding: 2px 6px;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            font-size: 10pt;
        }}
        pre {{
            background-color: #1e293b;
            color: #e2e8f0;
            padding: 20px;
            border-radius: 8px;
            overflow-x: auto;
            font-size: 9pt;
        }}
        pre code {{
            background-color: transparent;
            color: inherit;
        }}
        blockquote {{
            border-left: 4px solid #2563eb;
            margin: 20px 0;
            padding: 15px 20px;
            background-color: #eff6ff;
            font-style: italic;
        }}
        hr {{
            border: none;
            border-top: 2px solid #e2e8f0;
            margin: 30px 0;
        }}
        strong {{
            color: #1e293b;
        }}
        .cover-page {{
            text-align: center;
            padding-top: 200px;
        }}
        ul, ol {{
            margin: 15px 0;
            padding-left: 30px;
        }}
        li {{
            margin: 8px 0;
        }}
    </style>
</head>
<body>
{html_content}
</body>
</html>
"""

output_path = 'docs/NLQ_Engine_Enterprise_Documentation.pdf'
HTML(string=full_html).write_pdf(output_path)

print(f"PDF generated successfully: {output_path}")
