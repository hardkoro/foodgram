from io import BytesIO

from django.http.response import FileResponse
from reportlab.pdfbase.pdfmetrics import registerFont
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas

FILE_NAME = 'shopping_cart.pdf'
FILE_HEADER = 'Shopping List'

FONT_NAME = 'Verdana'
ITEMS_PER_PAGE = 35


def export_shopping_list_to_pdf(data):
    buffer = BytesIO()
    pdf = canvas.Canvas(buffer)
    registerFont(TTFont(FONT_NAME, f'{FONT_NAME}.ttf'))
    pdf.setFont(FONT_NAME, 16)
    pdf.drawString(250, 800, FILE_HEADER)
    height = 790
    pdf.setFont(FONT_NAME, 12)
    for i, (item, data) in enumerate(data.items(), 1):
        pdf.drawString(
            50, height,
            f"• {item} ({data['measurement_unit']}) — {data['amount']}"
        )
        height -= 20
        if i % ITEMS_PER_PAGE == 0:
            pdf.showPage()
            height = 790
    pdf.showPage()
    pdf.save()
    buffer.seek(0)
    return FileResponse(
        buffer, as_attachment=True, filename=FILE_NAME
    )
