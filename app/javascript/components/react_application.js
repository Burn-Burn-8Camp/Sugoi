import ReactOnRails from 'react-on-rails';
// 套件方法
import Hello from './HelloWorld';
import Counter from './counter';





// 類似於 ReactDOM.render() 不用綁標籤
// 而是輸出一個一個模板實體類似於vue
ReactOnRails.register({
  Hello, Counter
});