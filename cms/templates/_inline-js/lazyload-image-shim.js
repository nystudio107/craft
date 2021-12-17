// From https://web.dev/native-lazy-loading/#how-do-i-handle-browsers-that-don't-yet-support-native-lazy-loading
if ('loading' in HTMLImageElement.prototype) {
    // Replace the img.src with what is in the data-src property
    const images = document.querySelectorAll('img[loading="lazy"]');
    images.forEach(img => {
        img.src = img.dataset.src;
    });
    // Replace the source.srcset with what is in the data-srcset property
    const sources = document.querySelectorAll('source[data-srcset]')
    sources.forEach(source => {
        source.srcset = source.dataset.srcset;
    });
} else {
    // Dynamically import the LazySizes library
    const script = document.createElement('script');
    script.type = 'module';
    script.src =
        '{{ craft.vite.entry("src/js/utils/lazysizes-wrapper.ts") }}';
    document.body.appendChild(script);
}
