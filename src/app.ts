const { chromium } = require('playwright-chromium');

(async () => {
    while (true) {
        const browser = await chromium.launch({ headless: false, slowMo: 50 });
        const context = await browser.newContext();
        const page = await context.newPage();
        await page.goto('http://whatsmyuseragent.org/');
        await page.screenshot({ path: `example.png` });
        await browser.close();  
    }
})();
