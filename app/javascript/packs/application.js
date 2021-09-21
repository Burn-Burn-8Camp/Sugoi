import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "styles"
import "components/react_application"

import "scripts"

Rails.start()
Turbolinks.start()
ActiveStorage.start()