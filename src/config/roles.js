const allRoles = {
  user: ['getTipsUser','OffsetApp','getUsers', 'addCarbonFootprint', 'addHomeFootprint', 'addMobilityFootprint', 'addGearFootprint', 'addOtherFootprint', 'addPublicShareFootprint', 'getAllCalculationByUserId', 'getAllTipData', 'getTipData','getCmsApp'],
  admin: ['getTipsAdmin','OffsetAdmin','sendNotification','userBlockAdmin','getUsers', 'manageUsers', 'addTips', 'getAllTipData', 'getAllCalculationByUserId', 'getTipData', 'editTipsData', 'deleteTipsData', 'getAllUserCalculation','getCms'],
};

const roles = Object.keys(allRoles);
const roleRights = new Map(Object.entries(allRoles));

module.exports = {
  roles,
  roleRights,
};
