import ReactOnRails from 'react-on-rails';
// 套件方法
import Hello from './HelloWorld';
import Counter from './counter';
// 引入 component 位置
// 上面命名跟下面要對到




// 這邊只是來引入跟輸出而已


// 類似於 ReactDOM.render() 不用綁標籤
// 而是輸出一個一個模板實體類似於vue
ReactOnRails.register({
  Hello, Counter
});
// 下面命名跟上面要對到pr