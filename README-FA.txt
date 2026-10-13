Vex Panel — Railway deployment package

مهم:
- این بسته، برنامه PHP را روی Railway اجرا می‌کند؛ به‌تنهایی منطق ساخت VPN/Workerهای Cloudflare را به سرویس دیگری تبدیل نمی‌کند. کد فعلی هنوز شامل APIها و تنظیمات Cloudflare است.
- برای ماندگاری دیتابیس SQLite، فایل‌های آپلود و کلید رمزنگاری، حتماً در Railway یک Volume بساز و آن را روی مسیر زیر Mount کن:
  /var/www/html/data
- اگر Volume وصل نشود، اطلاعات ذخیره‌شده ممکن است بعد از redeploy/restart از دست بروند.

مراحل:
1) فایل‌های این بسته را در یک GitHub repository آپلود کن.
2) در Railway یک Project بساز و Deploy from GitHub Repo را انتخاب کن.
3) Railway باید Dockerfile را خودکار تشخیص بدهد.
4) از بخش Volumes یک Volume بساز و Mount Path را دقیقاً /var/www/html/data بگذار.
5) پس از Deploy، دامنه عمومی Railway را فعال کن.
6) آدرس https://YOUR-DOMAIN/?__health=1 را باز کن؛ باید عبارت DEMON PHP OK را نشان دهد.
7) قبل از استفاده واقعی، ورود مدیر، آپلود فایل، ساخت سرویس و APIهای Cloudflare را آزمایش کن.

امنیت:
- رمز مدیر پیش‌فرض در سورس index.php قرار دارد. پیش از انتشار عمومی، آن را تغییر بده و از رمز قوی و یکتا استفاده کن.
- داده‌ها و کلید رمزنگاری داخل Volume نگهداری می‌شوند؛ از Volume پشتیبان بگیر.
- این بسته صرفاً استقرار وب‌اپ PHP را فراهم می‌کند و تضمین نمی‌کند خطای 502/1101 مربوط به Workerهای Cloudflare رفع شود. برای حذف کامل Cloudflare باید منطق ایجاد و اجرای Workerها جداگانه بازطراحی شود.
