import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
// import '../stylesheets/appliciation.scss'
import "styles"
import "components"
import "scripts"


Rails.start()
Turbolinks.start()
ActiveStorage.start()
require("channels")

