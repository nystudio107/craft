<template>
    <confetti></confetti>
</template>

<script lang="ts">
// Async load the Vue 3 APIs we need from the Vue ESM
import {defineAsyncComponent, defineComponent } from 'vue';
import Confetti from '@/vue/Confetti.vue';
export default defineComponent({
  components: {
    'confetti': Confetti,
  },
  data: () => ({
  }),
  methods: {
  },
  mounted() {
  },
});
</script>
