return {
    "numToStr/Comment.nvim",
    config = function()
        require('Comment').setup()
        require('Comment.ft').set('blade', '{{-- %s --}}')
    end
}
