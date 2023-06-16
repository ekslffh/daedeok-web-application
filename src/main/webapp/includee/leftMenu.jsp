<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav id="sidebarMenu"
	class="col-md-2 col-lg-2 d-md-block bg-light sidebar collapse">
	<div class="sidebar-sticky pt-3">
		<ul class="nav flex-column">
			<li class="nav-item">
			<a class="nav-link" data-href="/bloodType" href="javascript:;">혈액형</a>
			</li>
			<li class="nav-item"><a class="nav-link" data-href="/02/gugudan.do" href="javascript:;">구구단</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" data-href="/calculate/Case6ProcessServlet" href="javascript:;">사칙연산</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" data-href="/calendarCase3"href="javascript:;">calendar</a>
			</li>
		</ul>
	</div>
</nav>
<script>
	$("a[data-href]").on("click", (event) => {
		event.preventDefault();
		let href = event.target.dataset.href;
		location.href = `<%=request.getContextPath() %>\${href}`;
	});
</script>