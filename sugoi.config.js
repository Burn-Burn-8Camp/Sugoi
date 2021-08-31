const autoprefixer = require('autoprefixer')
const colors = require('tailwindcss/colors')

module.exports = {
  corePlugins: {
    container: false,
  },
  
  darkMode: false, // or 'media' or 'class'
  theme: {
    
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [
    function ({ addComponents }) {
      addComponents({
        '.container': {
          maxWidth: '100%',
          '@screen xl': {
            maxWidth: '1200px',
          },
        }
      })
    }
  ],
}

