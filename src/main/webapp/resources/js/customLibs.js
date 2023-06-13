// 플러그인 : jQuery가 있어야만 사용가능!

$.fn.serializeObject = function() {
	let data = {};
	let nameSet = new Set();
	// 		this is jQuery object
	this.find(":input[name]").each((idx, ipt) => {
		nameSet.add(ipt.name);
	});
	let $formThis = this;
	nameSet.forEach(n => {
		let $ipt = $formThis.find(`:input[name=${n}]`)
		let type = $ipt.attr("type");
		let value = null;
		if (type == "radio") {
			value = $ipt.filter((idx, rdoIpt) => {
				return rdoIpt.checked;
			}).val();
		} else if (type == "checkbox") {
			value = $ipt.filter((idx, chkIpt) => chkIpt.checked)
				.get()
				.map(i => i.value)
		} else if (type == "number") {
			value = $ipt.val(); // value 속성 값을 반환. (attribute는 String 타입.)
			value = parseInt(value);
		} else {
			value = $ipt.val(); // value 속성 값을 반환. (attribute는 String 타입.)	
		}
		data[n] = value;
	});
	return data;
};