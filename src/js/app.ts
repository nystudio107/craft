import App from '@/vue/App.vue';
import { createApp } from 'vue';

// Import our CSS
import '@/css/app.pcss';

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
