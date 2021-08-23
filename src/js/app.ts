import App from '@/vue/App.vue';
import { createApp } from 'vue';

// Import our CSS
import '@/css/app.pcss';

import $ from 'jquery';
import Flickity from 'flickity';

// Import flickity styles for gallery
import 'flickity/css/flickity.css';

// Test if jQuery is loaded.
console.log($);
$('#test-container').html('It works from app.ts from /src/js');


// Intialize galleries https://flickity.metafizzy.co/#initialize-with-vanilla-javascript
var elem = document.querySelector('.main-carousel');
var flkty = new Flickity( elem, {
  // options
  cellAlign: 'left',
  contain: true
});

// App main
const main = async () => {
    // Create our vue instance
    const app = createApp(App);
    // Mount the app
    const root = app.mount('#component-container');

    return root;
};

// Execute async function
main().then( (root) => {
});
