// Import our CSS
import '../css/app.pcss';

// App main
const main = async () => {
    // Async load the Vue 3 APIs we need from the Vue ESM
    const { createApp, defineAsyncComponent } = await import(/* webpackChunkName: "vue" */ 'vue');
    // Create our vue instance
    const app = createApp({
        components: {
            'confetti': defineAsyncComponent(() => import(/* webpackChunkName: "confetti" */ '../vue/Confetti.vue')),
        },
        data: () => ({
        }),
        methods: {
        },
        mounted() {
        },
    });

    // Mount the app
    const root = app.mount("#page-container");

    return root;
};

// Execute async function
main().then( (root) => {
});

// Accept HMR as per: https://webpack.js.org/api/hot-module-replacement#accept
if (module.hot) {
    module.hot.accept();
}
