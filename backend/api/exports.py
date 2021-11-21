from io import BytesIO

from django.http.response import FileResponse
from reportlab.pdfbase.pdfmetrics import registerFont
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas

FILE_NAME = 'shopping_cart.pdf'
FILE_HEADER = 'Shopping List'

FONT_NAME = 'Verdana'


def export_shopping_list_to_pdf(data):
    buffer = BytesIO()
    pdf = canvas.Canvas(buffer)
    registerFont(TTFont(FONT_NAME, f'{FONT_NAME}.ttf'))
    pdf.setFont(FONT_NAME, 16)
    pdf.drawString(250, 800, FILE_HEADER)
    item_start_height = 790
    pdf.setFont(FONT_NAME, 12)
    for i, (item, data) in enumerate(data.items(), 1):
        pdf.drawString(
            50, item_start_height - 20 * i,
            f"{i}. {item}: {data['amount']} {data['measurement_unit']}"
        )
    pdf.showPage()
    pdf.save()
    buffer.seek(0)
    return FileResponse(
        buffer, as_attachment=True, filename=FILE_NAME
    )
