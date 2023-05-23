import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["subscribe"]

    async sub() {
        let id = this.subscribeTarget.value
        let data = id.split(/[ ,]+/)
        console.log(data)
        fetch("http://127.0.0.1:3000/editions/sub/" + data[0] + "/" + data[1])
            .then(() => location.reload())
            .catch((err) => alert(err))
    }

    async unsub() {
        let id = this.subscribeTarget.value
        let data = id.split(/[ ,]+/)
        fetch("http://127.0.0.1:3000/editions/unsub/" + data[0] + "/" + data[1])
            .then(() => location.reload())
            .catch((err) => alert(err))
    }
}
