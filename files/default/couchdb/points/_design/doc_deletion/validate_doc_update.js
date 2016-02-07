function(newDoc, oldDoc, userCtx, secObj) {
  if(newDoc._deleted) {
    var admin = userCtx.roles.indexOf('_admin') > -1;
    if(!admin) {
      throw({ 'forbidden': 'Only admins may delete documents' });
    }
  }
}
