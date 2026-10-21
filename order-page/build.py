# Build the live order site (dist/) from the page source (sophanua-order.html).
# Run: python3 build.py   then deploy dist/ (see README).
import shutil, os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
s = open('sophanua-order.html', encoding='utf-8').read()
font_url = s[s.index('https://fonts.googleapis.com/css2'):]
font_url = font_url[:font_url.index('"')]
fonts = f'''<link rel="preload" as="style" href="{font_url}">
<link rel="stylesheet" href="{font_url}" media="print" onload="this.media='all'">
<noscript><link rel="stylesheet" href="{font_url}"></noscript>'''
body = s[s.index('<style>'):]
head = f'''<!doctype html>
<html lang="lo">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>ສັ່ງໂສພານົວ · ນ້ຳປາແດກປຸງລົດ | Sophanua</title>
<meta name="description" content="ສັ່ງນ້ຳປາແດກປຸງລົດ ໂສພານົວ 350 ມລ. ເລືອກ 1 ຂວດ ຫຼື 1 ແພັກ 12 ຂວດ ແລ້ວສັ່ງຜ່ານ WhatsApp ໄດ້ເລີຍ.">
<meta name="theme-color" content="#110b07">
<meta property="og:type" content="website">
<meta property="og:site_name" content="ໂສພານົວ Sophanua">
<meta property="og:title" content="ສັ່ງໂສພານົວ · ນ້ຳປາແດກປຸງລົດ">
<meta property="og:description" content="ເລືອກ 1 ຂວດ ຫຼື 1 ແພັກ 12 ຂວດ ແລ້ວສັ່ງຜ່ານ WhatsApp.">
<meta property="og:image" content="/media/og.jpg">
<meta name="twitter:card" content="summary_large_image">
<link rel="icon" type="image/png" href="/media/icon.png">
<link rel="apple-touch-icon" href="/media/icon.png">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
{fonts}
<link rel="preload" as="image" href="media/bottle.webp?v=studio3" fetchpriority="high">
'''
end = body.index('</style>') + len('</style>')
html = head + body[:end] + '\n</head>\n<body>\n' + body[end:] + '\n</body>\n</html>\n'
out = 'dist'
os.makedirs(out + '/media', exist_ok=True)
open(out + '/index.html', 'w', encoding='utf-8').write(html)
for f in ('bottle.webp', 'mvm.webp', 'og.jpg', 'icon.png'):
    shutil.copy2('media/' + f, out + '/media/' + f)
shutil.copy2('_headers', out + '/_headers')
print('built', len(html))
