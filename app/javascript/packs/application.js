import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "styles"
// CSS 打包
import "components/react_application"
// react js 打包
import "controllers/stateStep"
import "controllers/swiftImg"
import 'controllers'
import 'controllers/confirmCart'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

