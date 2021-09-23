import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "styles"
import "components"
import "scripts"
import "chartkick/chart.js"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

