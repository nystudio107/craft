// module exports
module.exports = {
  mode: 'jit',
  purge: {
    content: [
      '../cms/templates/**/*.{twig,html}',
      '../src/vue/**/*.{vue,html}',
    ],
    layers: [
      'base',
      'components',
      'utilities',
    ],
    mode: 'layers',
    options: {
    }
  },
  theme: {
    // Extend the default Tailwind config here
    extend: {
    },
    // Replace the default Tailwind config here
  },
  corePlugins: {},
  plugins: [],
};
