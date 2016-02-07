function(newDoc, oldDoc, userCtx, secObj) {
  var admin = userCtx.roles.indexOf('_admin') > -1;
  if(newDoc._deleted) {
    return;
  } else if(admin) {
    return;
  } else if(newDoc._id.match(/^point\/.*/)) {
    return;
  } else {
    throw({ 'forbidden': 'Document ids must begin with `point/`'});
  }
}
