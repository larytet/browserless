const { chromium } = require('playwright-chromium');

(async () => {
        // https://playwright.dev/#version=v1.2.1&path=docs%2Fapi.md&q=browsertypelaunchoptions
        const browser = await chromium.launch({ headless: false, slowMo: 0 });
        const context = await browser.newContext();
        while (true) {
            const page = await context.newPage();
            await page.goto('http://cnn.com/');
            // await page.screenshot({ path: `cnn.png` });
            page.close()
        }
        await browser.close();  
})();
