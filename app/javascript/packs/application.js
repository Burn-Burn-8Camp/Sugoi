import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "styles"
// CSS 打包
import "components/react_application"
// react js 打包

import "styles"
// CSS 打包
import "components/react_application"
// react js 打包
import "@fortawesome/fontawesome-free/css/all"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
