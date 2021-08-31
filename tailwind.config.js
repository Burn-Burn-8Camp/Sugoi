module.exports = {
  presets: [
    require('./sugoi.config')
  ],
  mode: 'jit',
  purge: [
    './app/**/*.html',
    './app/helpers/**/*.rb',
    './app/views/**/*.html.erb',
    './public/**/*.html',
    './app/**/*.{js,jsx,ts,tsx,vue}',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    screens: {
      'md' : '375px',
      'lg' : '678px',
      'xl' : '1200px',
      'xxl' : '1400px',
    },
    debugScreens: {
      position: ['top', 'left'],
    },
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('tailwindcss-debug-screens'),
  ],
}

