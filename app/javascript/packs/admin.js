import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@fortawesome/fontawesome-free/js/all"
import "stylesheets/admin.css"
import "src/preview"

Rails.start()
ActiveStorage.start()