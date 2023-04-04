vim.g.projectionist_heuristics = {
    artisan = {
        ['*'] = {
            start = 'sail up',
            console = 'sail tinker',
            make = 'npm run dev',
        },
        ['app/Models/*.php'] = {
            type = 'model',
        },
        ['app/Http/Controllers/*.php'] = {
            type = 'controller',
        },
        ['routes/*.php'] = {
            type = 'route',
        },
        ['database/migrations/*.php'] = {
            type = 'migration',
        },
        ['app/*.php'] = {
            type = 'source',
            alternate = {
                'tests/Unit/{}Test.php',
                'tests/Feature/{}Test.php',
            },
        },
        ['app/Http/Livewire/*.php'] = {
            type = 'source',
            alternate = 'resources/views/livewire/{snakecase|hyphenate}.blade.php',
        },
        ['resources/views/livewire/*.blade.php'] = {
            type = 'view',
            alternate = 'app/Http/Livewire/{camelcase|capitalize}.php',
        },
        ['tests/*Test.php'] = {
            type = 'test',
            alternate = 'app/{}.php',
        },
        ['tests/Livewire/*Test.php'] = {
            type = 'test',
            alternate = 'app/Http/Livewire/{}.php',
        },
        ['tests/Feature/*Test.php'] = {
            type = 'test',
            alternate = 'app/{}.php',
        },
        ['tests/Unit/*Test.php'] = {
            type = 'test',
            alternate = 'app/{}.php',
        },
    },
}
