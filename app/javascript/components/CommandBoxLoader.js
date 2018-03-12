import $ from 'jquery'
import TableTopFlux from './TableTopFlux'

class CommandBoxLoader {
  fetch(data) {
    const url = `/command`
    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'json',
      data: data,
      success: (data) => {
        this.fetchDataDone(data)
      },
      error: (textStatus, errorThrown) => {
        this.fetchDataFail(textStatus, errorThrown)
      }
    })
  }


  fetchDataDone(payload) {
    TableTopFlux.actions.update(payload)
  }

  fetchDataFail(jqXHR, textStatus) {
    window.xhrr=jqXHR
    if (jqXHR && jqXHR.responseJSON && jqXHR.responseJSON.error) {
      TableTopFlux.actions.update({report: jqXHR.responseJSON.error})
    }
  }
}

export default CommandBoxLoader
