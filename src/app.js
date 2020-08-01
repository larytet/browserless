const { chromium } = require('playwright-chromium');

(async () => {
    while (true) {
        const browser = await chromium.launch({ headless: true, slowMo: 50 });
        const page = await browser.newPage();
        await page.goto('http://whatsmyuseragent.org/');
        await page.screenshot({ path: `example.png` });
        await browser.close();  
    }
})();