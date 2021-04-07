- dashboard: lookmldashtest
  title: lookmldashtest
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: New Tile
    name: New Tile
    model: josh_look
    explore: order_items
    type: single_value
    fields: [users.count, users.gender]
    pivots: [users.gender]
    sorts: [users.gender]
    limit: 500
    font_size: medium
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#ffffff"
    conditional_formatting: [{type: greater than, value: 0, background_color: "#ffb232",
        font_color: "#ffffff", color_application: {collection_id: test-new-color-combo,
          palette_id: test-new-color-combo-sequential-0}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    row:
    col:
    width:
    height:
