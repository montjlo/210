project_name: "josh_look"

constant: VIS_LABEL {
  value: "aa_josh_test_histogram"
  export: override_optional
}

constant: VIS_ID {
  value: "aa_josh_test_histogram"
  export:  override_optional
}

visualization: {
  id: "@{VIS_ID}"
  file: "histogram.js"
  label: "@{VIS_LABEL}"
}
