# คลิปโฆษณาปลาร้า — สูตรจากคลิปต้นแบบ (Pixury, TikTok)

## สิ่งที่แกะได้จากคลิปต้นแบบ
- แนวตั้ง 9:16 ยาว 16 วินาที มี 10 ช็อต ช็อตละประมาณ 1.5 วินาที ตัดตามจังหวะเพลง
- ไม่มีคนพูด มีแค่เพลงจังหวะหนักกับเสียงประกอบ (วูบ / น้ำกระเด็น / มีดหั่น)
- ทุกช็อตสร้างด้วย AI จากรูปสินค้าจริง (รูป → วิดีโอ) ไม่ได้ถ่ายทำจริง
- ฉากคุมโทนเดียวทั้งคลิป: พื้นหินอ่อนดำเปียก แสงลำจากด้านบน พื้นหลังมืด
- กล้องเคลื่อนตลอดทุกช็อต: ดันเข้า หมุนรอบ เอียงกล้อง สโลว์โมชัน
- ฉลากสินค้าต้องอ่านออกและเหมือนของจริงทุกช็อต (จุดนี้สำคัญที่สุด)
- โลโก้ติดมุมล่างตลอด ช็อตจบเป็นสินค้าทุกรสเรียงแถวพร้อมน้ำกระเด็น

## วิธีทำ (Google Flow)
1. รูปสินค้าจริง → **Nano Banana** (สร้างรูป) วางขวดลงฉาก ทีละช็อต = ภาพเริ่มต้น
2. ภาพเริ่มต้น → **Veo 3.1 Frames to Video** สร้างคลิปช็อตละ 4–8 วินาที (ใส่ท่าทางกล้องใน prompt)
3. ทำช็อตละ 2–4 เทค เลือกอันที่ฉลากไม่เพี้ยน
4. Neo ตัดต่อ: เลือกท่อนดีที่สุดช็อตละ ~1.5 วินาที ตัดตามจังหวะ ใส่เพลง เสียงประกอบ โลโก้ ข้อความปิดท้าย

## โทนฉากสำหรับปลาร้า
หินดำเปียก หรือเขียงไม้เก่า + ครกดินเผา แสงโทนอุ่นทองจากด้านบน มีควันไอลอย
ของประกอบฉาก: พริกขี้หนู มะนาว กระเทียม มะเขือเทศ ถั่วฝักยาว มะละกอเส้น ใบมะกรูด น้ำปลาร้าสีน้ำตาลเข้มข้น

## Shot list (prompt สำหรับ Veo ใช้ภาษาอังกฤษจะได้ผลดีกว่า)
| # | ช็อต | Prompt (ต่อท้ายภาพเริ่มต้นจาก Nano Banana) |
|---|------|------|
| 1 | เปิด: ขวดตั้งไกลบนหินดำ | Slow dolly-in toward the bottle(s) standing on wet black stone, warm god rays from above, light haze, cinematic, dark moody premium food commercial. Keep the label exactly as in the image. |
| 2 | หมุนรอบขวดใกล้ ๆ | Smooth orbit around the bottle close-up, label sharp and readable, reflections on wet stone, shallow depth of field. |
| 3 | ตำครก / หั่นมะนาว สโลว์ | Extreme slow motion: a knife slices a lime in half, juice splashes in the air, dark background, backlit droplets. |
| 4 | ขวดเอียง พริกลอย | Dutch-angle close-up of the bottle tilting, red chilies and a lime half floating past the lens, slow motion. |
| 5 | วัตถุดิบระเบิดรอบขวด | Explosion of Thai ingredients around the bottle: bird's eye chilies, garlic, lime, cherry tomatoes, long beans, shredded papaya, a ring of thick brown sauce splashing, frozen slow motion, camera pushes in. |
| 6 | เทน้ำปลาร้าลงครก | Slow motion pour of thick dark-brown fermented fish sauce into a clay mortar of som tam, glossy texture, steam, warm light. |
| 7 | ขวดลอยในแสงทอง | The bottle floats in the air, warm golden light rays from above, drifting steam and glowing embers, slow rotation. |
| 8 | จบ: ทุกรสเรียงแถว + น้ำกระเด็น | Hero shot: the product lineup on wet black stone, a crown splash of brown sauce erupts behind them, camera slowly pulls back, reflections. |

ข้อความบนจอ (ใส่ตอนตัดต่อ ไม่ให้ AI วาด): ชื่อสินค้า · สโลแกนสั้น · ช่องทางสั่งซื้อ
