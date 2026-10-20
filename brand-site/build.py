# Build the brand website (dist/) from the page source (src/sophanua.html).
# Run: python3 build.py   then: npx wrangler@4 deploy (see README).
import shutil, os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
s = open('src/sophanua.html', encoding='utf-8').read()
body = s[s.index('<style>'):]
fonts = s[s.index('<link rel="stylesheet" href="https://fonts.googleapis.com'):]
fonts = fonts[:fonts.index('>') + 1]
head = '''<!doctype html>
<html lang="lo">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>ໂສພານົວ · ນ້ຳປາແດກປຸງລົດ | Sophanua</title>
<meta name="description" content="ນ້ຳປາແດກປຸງລົດ ໂສພານົວ ຂະໜາດ 350 ມລ. ຫອມ ນົວ ເຂັ້ມຂຸ້ນ ພ້ອມໃຊ້ ໃສ່ໄດ້ທຸກເມນູລາວ. ຮັບສະໝັກຕົວແທນຈຳໜ່າຍທົ່ວປະເທດ.">
<meta name="theme-color" content="#110b07">
<meta property="og:type" content="website">
<meta property="og:site_name" content="ໂສພານົວ Sophanua">
<meta property="og:title" content="ໂສພານົວ · ນ້ຳປາແດກປຸງລົດ">
<meta property="og:description" content="ຫອມ ນົວ ເຂັ້ມຂຸ້ນ ພ້ອມໃຊ້ ໃສ່ໄດ້ທຸກເມນູລາວ.">
<meta property="og:image" content="/media/og.jpg">
<meta name="twitter:card" content="summary_large_image">
<link rel="icon" type="image/png" href="/media/icon.png">
<link rel="apple-touch-icon" href="/media/icon.png">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
''' + fonts + '''
<link rel="preload" as="image" href="media/bottle.webp" fetchpriority="high">
'''
end = body.index('</style>') + len('</style>')
html = head + body[:end] + '\n</head>\n<body>\n' + body[end:] + '\n</body>\n</html>\n'
os.makedirs('dist', exist_ok=True)
open('dist/index.html', 'w', encoding='utf-8').write(html)
for root, dirs, files in os.walk('src/media'):
    for f in files:
        src = os.path.join(root, f); dst = src.replace('src/media', 'dist/media', 1)
        os.makedirs(os.path.dirname(dst), exist_ok=True); shutil.copy2(src, dst)
shutil.copy2('_headers', 'dist/_headers')
print('built', len(html))
