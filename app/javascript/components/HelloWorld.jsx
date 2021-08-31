import PropTypes from 'prop-types';
import React, { useState } from 'react';

// 每一個component的名字
const Hello = (props) => {
  const [name, setName] = useState(props.name);
  // 設定

  // 模板
  return (
    <div>
      <h3>Hello, {name}!</h3>
      <hr />
      <form>
        <label htmlFor="name">
          Say hello to:
          <input id="name" type="text" value={name} onChange={(e) => setName(e.target.value)} />
        </label>
      </form>
    </div>
  );
};


// 類似於v-model的綁定
Hello.propTypes = {
  name: PropTypes.string.isRequired, // this is passed from the Rails view
};




export default Hello;
// 輸出實體