<template>
  <div />
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import Confetti from 'vue-confetti/src/confetti.js';

const config: Partial<ConfettiConfig> = {
  defaultType: 'rect',
  defaultSize: 15,
  defaultColors: ['DodgerBlue', 'OliveDrab', 'Gold', 'pink', 'SlateBlue', 'lightblue', 'Violet', 'PaleGreen', 'SteelBlue', 'SandyBrown', 'Chocolate', 'Crimson'],
};
const confetti: ConfettiInterface = new Confetti();

onMounted(() => {
  confetti.start(config);
  setTimeout(() => {
    confetti.stop();
  }, 5000);
});
</script>
