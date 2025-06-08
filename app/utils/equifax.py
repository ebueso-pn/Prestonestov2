def denegate_application(calculates):
    """
    Returns True if any of the denegation conditions are met based on the calculates dict/object.
    """
    conditions = [
        # BAN
        ("be_saldomoraact_180_ban", 1000, "gt"),
        ("be_saldomoraact_150_ban", 1000, "gt"),
        ("be_saldomoraact_120_ban", 1000, "gt"),
        ("be_saldomoraact_90_ban", 1000, "gt"),
        ("be_saldomoraact_60_ban2000", 1000, "gt"),
        ("be_saldomoraact_30_ban2000", 1000, "gt"),
        ("be_ref_moraactual_60_ban2000", 0, "gt0"),
        ("be_ref_moraactual_30_ban2000", 0, "gt0"),
        ("be_ref_moraactual_90_ban", 0, "gt0"),
        ("be_ref_moraactual_120_ban", 0, "gt0"),
        ("be_ref_moraactual_150_ban", 0, "gt0"),
        ("be_ref_moraactual_180_ban", 0, "gt0"),
        # TAR
        ("be_saldo_moraact_30d_tar2000", 1000, "gt"),
        ("be_saldo_moraact_60d_tar2000", 1000, "gt"),
        ("be_saldo_moraact_90_tar", 1000, "gt"),
        ("be_saldo_moraact_120_tar", 1000, "gt"),
        ("be_saldo_moraact_150_tar", 1000, "gt"),
        ("be_saldo_moraact_180_tar", 1000, "gt"),
        ("be_ref_moraactual_30_tar2000", 0, "gt0"),
        ("be_ref_moraactual_60_tar0", 0, "gt0"),
        ("be_ref_moraactual_60_tar500", 0, "gt0"),
        ("be_ref_moraactual_60_tar1000", 0, "gt0"),
        ("be_ref_moraactual_60_tar1500", 0, "gt0"),
        ("be_ref_moraactual_60_tar2000", 0, "gt0"),
        ("be_ref_moraactual_90_tar", 0, "gt0"),
        ("be_ref_moraactual_120_tar", 0, "gt0"),
        ("be_ref_moraactual_150_tar", 0, "gt0"),
        ("be_ref_moraactual_180_tar", 0, "gt0"),
        # COM
        ("be_saldomoraact_30_com2000", 1000, "gt"),
        ("be_saldomoraact_60_com2000", 1000, "gt"),
        ("be_saldomoraact_90_com", 1000, "gt"),
        ("be_saldomoraact_120_com", 1000, "gt"),
        ("be_saldomoraact_150_com", 1000, "gt"),
        ("be_saldomoraact_180_com", 1000, "gt"),
        ("be_ref_moraactual_30_com2000", 1, "gt1"),
        ("be_ref_moraactual_60_com2000", 1, "gt1"),
        ("be_ref_moraactual_90_com", 1, "gt1"),
        ("be_ref_moraactual_120_com", 1, "gt1"),
        ("be_ref_moraactual_150_com", 1, "gt1"),
        ("be_ref_moraactual_180_com", 1, "gt1"),
    ]

    def get_value(obj, attr):
        # Support both dict and object with attributes
        if isinstance(obj, dict):
            return obj.get(attr, 0)
        return getattr(obj, attr, 0)

    for attr, threshold, op in conditions:
        value = get_value(calculates, attr)
        if op == "gt":
            if value > threshold:
                return True
        elif op == "gt0":
            if value > 0:
                return True
        elif op == "gt1":
            if value > 1:
                return True
    return False
