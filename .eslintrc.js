module.exports = {
  "parser": "babel-eslint",
  "extends": ["eslint:recommended", "plugin:react/all"],
  "plugins": ["react"],
  "env": {
    "jasmine": true,
    "node": true,
    "browser": true,
    "jquery": true
  },
  "globals": {
    "fetch": true
  },
  "rules": {
    "max-len": ["error", 120],
    "semi": ["error", "always"],
    "react/jsx-no-bind": 0,
    "quotes": ["error", "double"],
    "no-unused-vars": ["error", {"argsIgnorePattern": "^_"}],
    "react/forbid-prop-types": ["error", {"forbid": ["any"]}],
    "react/jsx-indent": ["error", 2],
    "react/jsx-closing-bracket-location": ["error", "after-props"],
    "react/forbid-component-props": ["error", { "forbid": ["style"] }],
    "react/prefer-stateless-function": ["error", { "ignorePureComponents": true }],
    "react/jsx-max-props-per-line": ["warn", { "maximum": 3 }],
    "react/jsx-no-literals": ["off"],
    "react/no-multi-comp": ["off"],
    "react/jsx-closing-tag-location": ["off"],
    "no-useless-escape": ["off"],
    "react/destructuring-assignment": ["off"],
    "react/no-set-state": ["off"],
    "react/no-unused-state": ["off"],
    "react/jsx-curly-brace-presence": ["off"],
    "react/jsx-child-element-spacing": ["off"],
    "react/jsx-one-expression-per-line": ["off"],
    "react/no-access-state-in-setstate": ["off"],
    "react/jsx-max-depth": ["error", { "max": 9 }],
    "react/static-property-placement": ["warn", "property assignment"],
    "react/jsx-props-no-spreading": ["off"],
    "react/prop-types": ["off"],
    "react/no-unsafe": ["off"],
    "react/require-optimization": ["off"],
    "react/function-component-definition": ["off"],
    "react/jsx-no-script-url": ["off"],
    "react/no-adjacent-inline-elements": ["off"]
  },
  "parserOptions": {
    "sourceType": "module"
  }
};
