<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    @vite(['resources/css/app.css', 'resources/js/app.js'])

    <title>Mi Aplicación</title>
</head>
<body>
	
	<h1 class="text-3xl font-bold text-blue-500">
			Hola Tailwind
	</h1>

	<div class="max-w-sm overflow-hidden rounded-xl border border-gray-200 bg-white shadow-md transition hover:shadow-xl">
	
	<img
			src="https://images.unsplash.com/photo-1780054694213-869dbdee8c9c?q=80&w=715&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
			alt="Producto"
			class="h-64 w-full object-cover"
	>

	<div class="p-5">
		<span class="rounded-full bg-blue-100 px-3 py-1 text-xs font-medium text-blue-700">
				Nuevo
		</span>

		<h3 class="mt-3 text-lg font-semibold text-gray-900">
				Audífonos Bluetooth
		</h3>

		<p class="mt-2 text-sm text-gray-600">
				Audífonos inalámbricos con cancelación de ruido y batería de larga duración.
		</p>

		<div class="mt-4 flex items-center justify-between">
				<span class="text-2xl font-bold text-gray-900">
						$99.99
				</span>

				<button
						class="rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white transition hover:bg-blue-700">
						Comprar
				</button>
		</div>

		<!-- Flecha -->
        <button
            onclick="toggleInfo(this)"
            class="mt-4 flex w-full justify-center"
        >
            <svg
                class="h-6 w-6 transition-transform duration-300"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
            >
                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M19 9l-7 7-7-7"
                />
            </svg>
        </button>

        <!-- Contenido oculto -->
        <div class="hidden pt-4 text-sm text-gray-600">
            <p>
                • Cancelación de ruido<br>
                • Batería de 30 horas<br>
                • Bluetooth 5.3<br>
                • Garantía de 1 año
            </p>
        </div>
	</div>

</div>

<script>
function toggleInfo(button) {
    const content = button.parentElement.querySelector('.hidden, .block');
    const icon = button.querySelector('svg');

    content.classList.toggle('hidden');
    content.classList.toggle('block');

    icon.classList.toggle('rotate-180');
}
</script>

</body>
</html>