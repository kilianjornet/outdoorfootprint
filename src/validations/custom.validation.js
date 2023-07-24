const objectId = (value, helpers) => {
  if (!value.match(/^[0-9a-fA-F]{24}$/)) {
    return helpers.message('"{{#label}}" must be a valid mongo id');
  }
  return value;
};

const password = (value, helpers) => {
  if (value.length < 8) {
    return helpers.message('password must be at least 8 characters');
  }
  if (!value.match(/\d/) || !value.match(/[a-zA-Z]/) || !value.match(/[!@#$%^&*]/)) {
    return helpers.message('password must contain at least 1 letter and 1 number and 1 special character');
  }
  return value;
};

const confirmPassword = (value, helpers) => {
  if (value.length < 8) {
    return helpers.message('Confirm password must be at least 8 characters');
  }
  if (!value.match(/\d/) || !value.match(/[a-zA-Z]/) || !value.match(/[!@#$%^&*]/)) {
    return helpers.message('Confirm password must contain at least 1 letter and 1 number and 1 special character');
  }
  return value;
};

const firstName = (value, helpers) => {
  const isOnlyLetters = /^[A-Za-z]+$/.test(value);
  if (!isOnlyLetters) {
    return helpers.message('First name is invalid. Only letters are allowed.');
  }
  return value;
};

const lastName = (value, helpers) => {
  const isOnlyLetters = /^[A-Za-z]+$/.test(value);
  if (!isOnlyLetters) {
    return helpers.message('Last name is invalid. Only letters are allowed.');
  }
  return value;
};

const phoneNumber = (value, helpers) => {
  const isOnlyNumbers = /^\d+$/.test(value);
  if (value.length < 10) {
    return helpers.message('Phone number must be at least 10 Numbers.');
  }
  if (!isOnlyNumbers) {
    return helpers.message('Phone number is invalid. Only Numbers are allowed.');
  }
  return value;
};

const GearQtyNumber = (value, helpers) => {
  const isOnlyNumbers = /^\d+$/.test(value);
  if (!isOnlyNumbers) {
    return helpers.message('Only Numbers are allowed, Quantity is invalid.');
  }
  return value;
};

const categoryFormat = (value, helpers) => {
  if (value != "home" && value != "mobility" && value != "gear" && value != "others" && value != "publicserviceshare") {
    return helpers.message('Category type should be home|mobility|gear|others|publicserviceshare');
  }
  return value;
};

const FloatNumberFormat = (value, helpers) => {
  const isOnlyNumbers = /^[0-9.]+$/.test(value);
  if (!isOnlyNumbers) {
    return helpers.message('Only digits and decimal points are allowed.');
  }
  return value;
};

module.exports = {
  objectId,
  password,
  confirmPassword,
  firstName,
  lastName,
  phoneNumber,
  GearQtyNumber,
  categoryFormat,
  FloatNumberFormat,
};
